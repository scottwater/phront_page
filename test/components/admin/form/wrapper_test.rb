# frozen_string_literal: true

require "test_helper"

class Admin::Form::Wrapper::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component

    render_inline(component)

    assert_selector "div"
  end

  private

  def build_component(**)
    Admin::Form::Wrapper::Component.new(**)
  end
end
