# frozen_string_literal: true

require "test_helper"

class Admin::Form::Select::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(name: :template, choices: Pages.select_list)
    render_inline(component)
    assert_selector "div"
  end

  private

  def build_component(**)
    form = form_with(Page.new)
    Admin::Form::Select::Component.new(form:, **)
  end
end
