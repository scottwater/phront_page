require "test_helper"
class CreateAutoRevisionForNewContentTest < ActiveSupport::TestCase
  test "should save the revision" do
    params = {"title" => "HEY"}
    form = CreateAutoRevisionForNewContentForm.new(params:, model_type: Post, revision_model_id: "abc")
    assert form.save!
    assert_equal "abc", form.revision.uid
    assert_equal Post.name, form.revision.record_type
    assert form.revision.auto_revision?
    assert_equal params, form.revision.data
  end

  test "should not detect changes if the revision does not differ from the previous revision" do
    params = {"title" => "HEY"}
    form = CreateAutoRevisionForNewContentForm.new(params:, model_type: Post, revision_model_id: "abc")
    assert form.save!
    new_form = CreateAutoRevisionForNewContentForm.new(params:, model_type: Post, revision_model_id: "abc")
    assert new_form.save!
    assert new_form.revision.attributes_with_changes.blank?
  end

  test "should detect change when the new revision has additional attributes" do
    params = {"title" => "HEY", "summary" => "HEY"}
    form = CreateAutoRevisionForNewContentForm.new(params:, model_type: Post, revision_model_id: "abc")
    assert form.save!
    params["summary"] = "NOT HEY"
    new_form = CreateAutoRevisionForNewContentForm.new(params:, model_type: Post, revision_model_id: "abc")
    assert new_form.save!
    assert_equal ["HEY", "NOT HEY"], new_form.revision.attributes_with_changes["summary"]
  end
end
