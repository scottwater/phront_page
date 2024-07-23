# frozen_string_literal: true

require "test_helper"

class Admin::Sidebar::SingleItem::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(text: "text", url: "url")
    render_inline(component)
    assert_selector "li a[href='url']", text: "text"
  end

  private

  def build_component(**)
    Admin::Sidebar::SingleItem::Component.new(**)
  end
end
