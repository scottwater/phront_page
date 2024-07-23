# frozen_string_literal: true

require "test_helper"

class Admin::Form::MarkdownArea::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(name: "markdown_area")

    content = render_inline(component)
    # debugger
    assert_selector "div textarea"
    assert content.css("div textarea[data-controller]").attr("data-controller").value.include?("form--markdown-area--component")
  end

  private

  def build_component(**)
    form = form_with(url: "/")
    Admin::Form::MarkdownArea::Component.new(form:, **)
  end
end
