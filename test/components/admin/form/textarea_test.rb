# frozen_string_literal: true

require "test_helper"

class Admin::Form::TextArea::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(name: :name)

    render_inline(component)
    assert_selector "div textarea[name='hash[name]']"
  end

  private

  def build_component(**)
    form = form_with(url: "/")
    Admin::Form::TextArea::Component.new(form:, **)
  end
end
