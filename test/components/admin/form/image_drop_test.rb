# frozen_string_literal: true

require "test_helper"

class Admin::Form::ImageDrop::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(name: :image)

    content = render_inline(component)

    assert_selector "div"
    assert content.css("div[data-controller]").attr("data-controller").value.include?("form--image-drop--component")
  end

  private

  def build_component(**)
    form = form_with(url: "/")
    Admin::Form::ImageDrop::Component.new(form:, **)
  end
end
