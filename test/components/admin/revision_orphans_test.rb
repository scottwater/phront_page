# frozen_string_literal: true

require "test_helper"

class Admin::RevisionOrphans::ComponentTest < ViewComponent::TestCase
  def test_renders_one
    component = build_component(orphans: [1], record_type: "Post")

    render_inline(component)
    assert_selector "div"
    assert_selector "a", text: "retreived from the database"
  end

  def test_renders_multiple
    component = build_component(orphans: [1, 2], record_type: "Post")

    render_inline(component)
    assert_selector "div"
    assert_selector "div", text: "There are 2"
  end

  private

  def build_component(**)
    Admin::RevisionOrphans::Component.new(**)
  end
end
