# frozen_string_literal: true

require "test_helper"

class Blog::Elements::Html::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(html: "<p>Test</p>")

    render_inline(component)

    assert_selector "div"
  end

  private

  def build_component(**)
    Blog::Elements::Html::Component.new(**)
  end
end
