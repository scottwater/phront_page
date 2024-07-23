# frozen_string_literal: true

require "test_helper"

class Admin::ModelList::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(button_text: "New Model", button_url: "#")

    render_inline(component)

    assert_selector "div"
    assert_selector "a", text: "New Model"
    assert_selector "table"
  end

  private

  def build_component(**)
    Admin::ModelList::Component.new(**)
  end
end
