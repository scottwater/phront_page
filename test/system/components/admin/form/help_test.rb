# frozen_string_literal: true

require "application_system_test_case"

class Admin::Form::Help::ComponentSystemTest < ApplicationSystemTestCase
  def test_default_preview
    visit("/rails/view_components/admin/form/help/default")

    assert_text "This is helpful!"
  end
end
