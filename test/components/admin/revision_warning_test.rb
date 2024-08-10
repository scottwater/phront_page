# frozen_string_literal: true

require "test_helper"

class Admin::RevisionWarning::ComponentTest < ViewComponent::TestCase
  def test_renders_with_auto_revision
    revision = Revision.create!(record_type: "Post", revision_type: :auto)
    component = build_component(revision:)

    render_inline(component)
    assert_selector "div", text: "You are currenting editing"
  end

  def test_does_not_render_with_no_revision
    component = build_component
    render_inline(component)
    assert_no_selector "div"
  end

  private

  def build_component(**)
    Admin::RevisionWarning::Component.new(**)
  end
end
