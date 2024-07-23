# frozen_string_literal: true

class Blog::Posts::Default::Preview < ApplicationViewComponentPreview
  # You can specify the container class for the default template
  # self.container_class = "w-1/2 border border-gray-300"

  def default
    render(Blog::Posts::Default::Component.new(post: Post.published.randomized.first))
  end

  def with_post(post_id:)
    post = Post.find(post_id)
    render(Blog::Posts::Default::Component.new(post: post))
  end
end
