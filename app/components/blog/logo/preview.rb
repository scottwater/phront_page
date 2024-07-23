# frozen_string_literal: true

class Blog::Logo::Preview < ApplicationViewComponentPreview
  # @param name text "The name of the blawg"
  # @param logo textarea "An inlined SVG for the logo"
  def default(name: "PhrontPage", logo: nil)
    render(Blog::Logo::Component.new(name: name, logo: logo))
  end
end
