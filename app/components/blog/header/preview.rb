# frozen_string_literal: true

class Blog::Header::Preview < ApplicationViewComponentPreview
  def default
    with_current_blog_config do
      render(Blog::Header::Component.new(pages: []))
    end
  end
end
