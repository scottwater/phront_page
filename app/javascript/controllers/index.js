// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"
// Eager load all controllers defined in the import map under controllers/**/*_controller
// import { eagerLoadControllersFr/Users/scott/Library/Application Support/CleanShot/media/media_Em9HaEYjWZ/CleanShot 2024-05-22 at 12.52.00@2x.pngom } from "@hotwired/stimulus-loading"
// allow controllers to be loaded from the app/components directory
// In the future, consdier using the original and custom for only controllers in the component directory
import { eagerLoadControllersFrom } from "controllers/custom_loader"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
import TextareaAutogrow from 'stimulus-textarea-autogrow'
application.register('textarea-autogrow', TextareaAutogrow)