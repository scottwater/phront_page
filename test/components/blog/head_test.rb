# frozen_string_literal: true

require "test_helper"

class Blog::Head::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component

    render_inline_with_blog_config(component)

    assert rendered_content.starts_with?("<head>")
  end

  private

  def build_component(**)
    Blog::Head::Component.new(**)
  end
end
