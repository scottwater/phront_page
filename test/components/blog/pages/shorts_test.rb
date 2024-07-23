# frozen_string_literal: true

require "test_helper"

class Blog::Pages::Shorts::ComponentTest < ViewComponent::TestCase
  def test_renders
    page = pages(:one)
    component = build_component(page:)

    render_inline(component)

    assert_selector "div"
  end

  private

  def build_component(**)
    Blog::Pages::Shorts::Component.new(**)
  end
end
