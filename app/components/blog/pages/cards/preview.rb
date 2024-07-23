# frozen_string_literal: true

class Blog::Pages::Cards::Preview < ApplicationViewComponentPreview
  def default
    page = Page.randomized.first
    posts = Post.published.randomized.limit(10)
    render(Blog::Pages::Cards::Component.new(page: page, posts: posts))
  end
end
