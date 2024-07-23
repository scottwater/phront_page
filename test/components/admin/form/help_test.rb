# frozen_string_literal: true

require "test_helper"

class Admin::Form::Help::ComponentTest < ViewComponent::TestCase
  def test_renders_with_help_text
    component = build_component(help: "Help text")
    render_inline(component)
    assert_selector "p", text: "Help text"
  end

  def test_renders_nothing_with_no_help_text
    component = build_component(help: nil)
    render_inline(component)
    assert_empty rendered_content
    refute_selector "p"
  end

  private

  def build_component(**)
    Admin::Form::Help::Component.new(**)
  end
end
