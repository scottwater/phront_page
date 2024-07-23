# frozen_string_literal: true

require "application_system_test_case"

class Admin::Flashed::ComponentSystemTest < ApplicationSystemTestCase
  def test_default_preview
    visit("/rails/view_components/admin/flashed/alert")
    assert_text "Error!"
    # click_on("Click me!")
    # assert_text "Good-bye!"
  end
end
