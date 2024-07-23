# frozen_string_literal: true

class Blog::Pages::Shorts::Preview < ApplicationViewComponentPreview
  def default
    page = Page.randomized.first
    posts = Post.published.randomized.limit(10)
    render(Blog::Pages::Shorts::Component.new(page: page, posts: posts))
  end
end
