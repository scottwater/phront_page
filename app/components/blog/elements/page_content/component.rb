# frozen_string_literal: true

class Blog::Elements::PageContent::Component < Blog::BlogViewComponent
  option :page
  erb_template <<~TEMPLATE
      <% pp = k(page) %>
      <div class="mx-auto max-w-screen-sm lg:mb-16 mb-8">
          <div class="text-center">
    <h2 class="mb-4 text-3xl lg:text-4xl tracking-tight font-extrabold text-gray-900 dark:text-white"><%= page.title %></h2>
          </div>
          <div class="max-w-none">
            <%= pp.html %>
          </div>
      </div>
  TEMPLATE
end
