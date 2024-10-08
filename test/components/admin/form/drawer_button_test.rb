# frozen_string_literal: true

require "test_helper"

class Admin::Form::DrawerButton::ComponentTest < ViewComponent::TestCase
  def test_renders_a_plain_button
    component = build_component
    render_inline(component)
    assert_selector "button[type=button]"
    # Default position on Right

    assert_selector "button[data-admin--form--drawer-button--component-position-value=right]"
    assert_selector "button[data-drawer-target=drawer-test-drawer]"
  end

  def test_renders_a_left_position
    component = build_component(position: :left)
    render_inline(component)
    assert_selector "button[data-admin--form--drawer-button--component-position-value=left]"
    assert_selector "button[data-drawer-target=drawer-test-drawer]"
  end

  private

  def build_component(**)
    Admin::Form::DrawerButton::Component.new(**, drawer_id: "test-drawer")
  end
end
