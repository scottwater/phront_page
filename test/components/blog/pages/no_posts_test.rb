# frozen_string_literal: true

require "test_helper"

class Blog::Pages::NoPosts::ComponentTest < ViewComponent::TestCase
  def test_renders
    page = pages(:one)
    posts = [posts(:one)]
    component = build_component(page:, posts:)
    render_inline(component)
    assert_selector "div"
    refute_match(/post.title/, rendered_content)
  end

  private

  def build_component(**)
    Blog::Pages::NoPosts::Component.new(**)
  end
end
