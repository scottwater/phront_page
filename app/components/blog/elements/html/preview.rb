# frozen_string_literal: true

class Blog::Elements::Html::Preview < ApplicationViewComponentPreview
  # You can specify the container class for the default template
  # self.container_class = "w-1/2 border border-gray-300"

  # @param html textarea "HTML Content to Preview"
  def default(html: nil)
    html ||= Content::Markdown.to_html(Faker::Markdown.sandwich(sentences: 15))
    render(Blog::Elements::Html::Component.new(html:))
  end
end
