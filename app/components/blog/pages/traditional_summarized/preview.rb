# frozen_string_literal: true

class Blog::Pages::TraditionalSummarized::Preview < ApplicationViewComponentPreview
  layout "blog_preview"
  def default
    page = Page.content_pages.randomized.first || default_page
    posts = Post.published.randomized.limit(10)
    render(Blog::Pages::TraditionalSummarized::Component.new(page: page, posts: posts))
  end
end
