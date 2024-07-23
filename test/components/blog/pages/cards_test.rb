# frozen_string_literal: true

require "test_helper"

class Blog::Pages::Cards::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(page: pages(:one))

    render_inline(component)

    assert_selector "div"
  end

  private

  def build_component(**)
    Blog::Pages::Cards::Component.new(**)
  end
end
