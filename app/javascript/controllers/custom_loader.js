// Mostly copy and pasted from https://github.com/hotwired/stimulus-rails/blob/main/app/assets/javascripts/stimulus-loading.js
// SHA 498902a3687d32bd6589f7d3c7e7d72eabd822c0

// Changes were to load paths from components that do not end with _controller. I will likely regret this, but
// with this in place we can drop controllers in app/components/component_name/controller.js and they will be loaded

import "@hotwired/stimulus"

const controllerAttribute = "data-controller"

// Eager load all controllers registered beneath the `under` path in the import map to the passed application instance.
export function eagerLoadControllersFrom(under, application) {
  const applicationPaths = Object.keys(parseImportmapJson()).filter(path => path.match(new RegExp(`^${under}/.*_controller$`)))
  const componentPaths = Object.keys(parseImportmapJson()).filter(path => path.match(new RegExp(`^${under}/.*/controller$`)));
  const paths = Array.from(new Set([...applicationPaths, ...componentPaths]))
  paths.forEach(path => registerControllerFromPath(path, under, application))
}

function parseImportmapJson() {
  return JSON.parse(document.querySelector("script[type=importmap]").text).imports
}

function registerControllerFromPath(path, under, application) {

  const name = path
    .replace(new RegExp(`^${under}/`), "")
    .replace("_controller", "")
    .replace(/\//g, "--")
    .replace(/_/g, "-")
    .replace("--controller", "--component")
  if (canRegisterController(name, application)) {
    import(path)
      .then(module => registerController(name, module, application))
      .catch(error => console.error(`Failed to register controller: ${name} (${path})`, error))
  }
}


// Lazy load controllers registered beneath the `under` path in the import map to the passed application instance.
export function lazyLoadControllersFrom(under, application, element = document) {
  lazyLoadExistingControllers(under, application, element)
  lazyLoadNewControllers(under, application, element)
}

function lazyLoadExistingControllers(under, application, element) {
  queryControllerNamesWithin(element).forEach(controllerName => loadController(controllerName, under, application))
}

function lazyLoadNewControllers(under, application, element) {
  new MutationObserver((mutationsList) => {
    for (const { attributeName, target, type } of mutationsList) {
      switch (type) {
        case "attributes": {
          if (attributeName == controllerAttribute && target.getAttribute(controllerAttribute)) {
            extractControllerNamesFrom(target).forEach(controllerName => loadController(controllerName, under, application))
          }
        }

        case "childList": {
          lazyLoadExistingControllers(under, application, target)
        }
      }
    }
  }).observe(element, { attributeFilter: [controllerAttribute], subtree: true, childList: true })
}

function queryControllerNamesWithin(element) {
  return Array.from(element.querySelectorAll(`[${controllerAttribute}]`)).map(extractControllerNamesFrom).flat()
}

function extractControllerNamesFrom(element) {
  return element.getAttribute(controllerAttribute).split(/\s+/).filter(content => content.length)
}

function loadController(name, under, application) {
  if (canRegisterController(name, application)) {
    import(controllerFilename(name, under))
      .then(module => registerController(name, module, application))
      .catch(error => console.error(`Failed to autoload controller: ${name}`, error))
  }
}

function controllerFilename(name, under) {
  return `${under}/${name.replace(/--/g, "/").replace(/-/g, "_")}_controller`
}

function registerController(name, module, application) {
  if (canRegisterController(name, application)) {
    application.register(name, module.default)
  }
}

function canRegisterController(name, application){
  return !application.router.modulesByIdentifier.has(name)
}
