# frozen_string_literal: true

class Blog::Elements::PostAnchor::Component < ApplicationViewComponent
  option :slug
  option :text, default: -> { "#" }
  option :published_at, optional: true

  def formatted_published_at
    published_at&.strftime("%B %d, %Y")
  end
  erb_template <<~TEMPLATE
    <div class="mt-4 inline-flex space-x-2 items-center font-medium text-gray-300 dark:text-primary-500">
      <a class="hover:underline" href="<%= slug%>" ><%= text %></a>
      <% if published_at %>
        <time datetime="<%= published_at.iso8601%>"><%= formatted_published_at %></time>
      <% end %>
    </div>
  TEMPLATE
end
