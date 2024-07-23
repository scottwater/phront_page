# frozen_string_literal: true

require "test_helper"

class Blog::Pages::Traditional::ComponentTest < ViewComponent::TestCase
  def test_renders
    page = pages(:two)
    component = build_component(page:)

    render_inline(component)

    assert_selector "div"
  end

  private

  def build_component(**)
    Blog::Pages::Traditional::Component.new(**)
  end
end
