# frozen_string_literal: true

require "test_helper"
require "view_component/test_helpers"

class Admin::Menu::ComponentTest < ViewComponent::TestCase
  def setup
    # Current.session = authors(:scott).sessions.create!
  end

  def test_renders
    component = build_component
    render_inline_with_default_author(component)
    assert_selector "div"
  end

  private

  def build_component(**)
    Admin::Menu::Component.new(**)
  end
end
