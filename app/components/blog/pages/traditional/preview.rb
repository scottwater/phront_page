# frozen_string_literal: true

class Blog::Pages::Traditional::Preview < ApplicationViewComponentPreview
  # You can specify the container class for the default template
  # self.container_class = "w-1/2 border border-gray-300"

  def default
    page = Page.randomized.first
    posts = Post.randomized.limit(10)
    render(Blog::Pages::Traditional::Component.new(page: page, posts: posts))
  end
end
