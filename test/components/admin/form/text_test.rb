# frozen_string_literal: true

require "test_helper"

class Admin::Form::Text::ComponentTest < ViewComponent::TestCase
  def test_renders_email_input
    component = build_component(name: :email, type: :email)
    render_inline(component)
    assert_selector "input[type=email]"
  end

  def test_renders_password_input
    component = build_component(name: :email, type: :password)
    render_inline(component)
    assert_selector "input[type=password]"
  end

  def test_renders_text_by_default
    component = build_component(name: :name)
    render_inline(component)
    assert_selector "input[type=text]"
  end

  private

  def build_component(**)
    form = form_with(url: "/")
    Admin::Form::Text::Component.new(form:, **)
  end
end
