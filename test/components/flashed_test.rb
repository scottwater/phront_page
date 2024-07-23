# frozen_string_literal: true

require "test_helper"

class Admin::Flashed::ComponentTest < ViewComponent::TestCase
  def test_notice_renders
    component = build_component(notice: "notice")
    render_inline(component)
    assert_selector "div#flash-notice"
    assert rendered_content.include?("data-turbo-temporary")
  end

  def test_alert_renders
    component = build_component(alert: "alert")
    render_inline(component)
    assert_selector "div#flash-alert"
  end

  private

  def build_component(**)
    Admin::Flashed::Component.new(**)
  end
end
