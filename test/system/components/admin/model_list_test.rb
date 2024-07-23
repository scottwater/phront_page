# frozen_string_literal: true

require "application_system_test_case"

class Admin::ModelList::ComponentSystemTest < ApplicationSystemTestCase
  def test_default_preview
    visit("/rails/view_components/admin/model_list/default")

    assert_text "Test"
    assert_text redirects(:one).from
    assert_selector "a[href='#{redirects(:two).from}']", text: "Test"
    # click_on("Click me!")
    # assert_text "Good-bye!"
  end
end
