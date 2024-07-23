# frozen_string_literal: true

require "application_system_test_case"

class Admin::Menu::ComponentSystemTest < ApplicationSystemTestCase
  def test_default_preview
    visit("/rails/view_components/admin/menu/default")
    assert_selector("a", text: "My Profile", visible: :all)
    assert_selector("a", text: "Log out", visible: :all)
  end
end
