# frozen_string_literal: true

class Blog::Elements::PostAnchor::Preview < ApplicationViewComponentPreview
  # @param text text "The text to display in the anchor"
  def default(text: "#")
    render(Blog::Elements::PostAnchor::Component.new(text:, slug: "/slug", published_at: Time.current))
  end
end
