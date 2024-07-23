# frozen_string_literal: true

require "test_helper"

class Admin::Menu::Account::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component
    render_inline_with_default_author(component)
    assert_selector "li a", text: "Log out"
  end

  private

  def build_component(**)
    Admin::Menu::Account::Component.new(**)
  end
end
