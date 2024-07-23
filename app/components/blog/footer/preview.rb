# frozen_string_literal: true

class Blog::Footer::Preview < ApplicationViewComponentPreview
  def default
    with_current_blog_config do
      component = Blog::Footer::Component.new
      render(component)
    end
  end
end
