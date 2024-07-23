# frozen_string_literal: true

require "test_helper"

class Blog::Elements::PostAnchor::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(slug: "/test")

    render_inline(component)

    assert_selector "a[href='/test']", text: "#"
  end

  private

  def build_component(**)
    Blog::Elements::PostAnchor::Component.new(**)
  end
end
