# frozen_string_literal: true

require "test_helper"

class Blog::Footer::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component
    render_inline_with_blog_config(component)
    assert_selector "footer"
  end

  test "renders a copyright notice" do
    blog_config = Config::Blog.new
    blog_config.meta.copyright = "Hello World"
    component = build_component
    render_inline_with_blog_config(component, blog_config:)
    assert_selector "footer", text: "Hello World"
  end

  private

  def build_component(**)
    Blog::Footer::Component.new(**)
  end
end
