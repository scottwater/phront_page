# frozen_string_literal: true

require "test_helper"

class Blog::Posts::Default::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component

    render_inline(component)

    assert_selector "div"
  end

  private

  def build_component(**)
    Blog::Posts::Default::Component.new(post: posts(:one), **)
  end
end
