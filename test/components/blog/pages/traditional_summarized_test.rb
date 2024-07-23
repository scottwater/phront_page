# frozen_string_literal: true

require "test_helper"

class Blog::Pages::TraditionalSummarized::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(page: pages(:two))

    render_inline(component)

    assert_selector "div"
  end

  private

  def build_component(**)
    Blog::Pages::TraditionalSummarized::Component.new(**)
  end
end
