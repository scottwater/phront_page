# frozen_string_literal: true

require "test_helper"

class Blog::Elements::PageContent::ComponentTest < ViewComponent::TestCase
  def test_renders
    page = pages(:one)
    component = build_component(page:)

    render_inline(component)

    assert_selector "div"
  end

  private

  def build_component(**)
    Blog::Elements::PageContent::Component.new(**)
  end
end
