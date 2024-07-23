# frozen_string_literal: true

require "test_helper"

class Admin::Form::Button::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component

    render_inline(component)

    assert_selector "button[type=submit]"
  end

  private

  def build_component(**)
    form = form_with(url: "/")
    Admin::Form::Button::Component.new(form:, **)
  end
end
