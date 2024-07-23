# frozen_string_literal: true

require "test_helper"

class Admin::Menu::SearchToggle::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component

    render_inline(component)

    assert_selector "button[type=button]"
  end

  private

  def build_component(**)
    Admin::Menu::SearchToggle::Component.new(**)
  end
end
