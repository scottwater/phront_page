# frozen_string_literal: true

class Blog::Pages::NoPosts::Preview < ApplicationViewComponentPreview
  # You can specify the container class for the default template
  # self.container_class = "w-1/2 border border-gray-300"

  def default
    page = Page.randomized.first || default_page
    render(Blog::Pages::NoPosts::Component.new(page: page))
  end
end
