# frozen_string_literal: true

require "test_helper"

class Admin::ModelErrors::ComponentTest < ViewComponent::TestCase
  def test_renders
    post = Post.new
    post.save
    component = build_component(model: post)

    render_inline(component)

    assert_selector "div ul li", count: 3
  end

  private

  def build_component(**)
    Admin::ModelErrors::Component.new(**)
  end
end
