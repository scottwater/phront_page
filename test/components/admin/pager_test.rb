# frozen_string_literal: true

require "test_helper"

class Admin::Pager::ComponentTest < ViewComponent::TestCase
  def test_renders_next_page
    component = build_component(url: "http://example.com/test?page=2")
    render_inline(component)
    assert_selector "a[href='/test?page=3']"
  end

  def test_renders_previous_page
    component = build_component(url: "http://example.com/test?page=2")
    render_inline(component)
    assert_selector "a[href='/test?page=1']"
  end

  def test_does_not_render_previous_page
    component = build_component(url: "http://example.com/test")
    render_inline(component)
    assert_no_selector "a[href='/test?page=1']"
  end

  def test_does_not_render_previous_page_two
    component = build_component(url: "http://example.com/test?page=1")
    render_inline(component)
    assert_no_selector "a[href='/test?page=1']"
  end

  def test_the_option_to_skip_next
    component = build_component(next: false, url: "http://example.com/test?page=1")
    render_inline(component)
    assert_no_selector "a[href='/test?page=2']"
  end

  private

  def build_component(**)
    Admin::Pager::Component.new(**)
  end
end
