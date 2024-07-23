# frozen_string_literal: true

require "test_helper"

class Admin::Logo::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(wrapped_class: "wrapped-class")

    render_inline(component)

    assert_css "a.wrapped-class"
  end

  private

  def build_component(**)
    Admin::Logo::Component.new(**)
  end
end
