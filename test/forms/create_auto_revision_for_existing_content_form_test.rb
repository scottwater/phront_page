require "test_helper"
class CreateAutoRevisionForExistingContentTest < ActiveSupport::TestCase
  test "should save the revision" do
    params = {"title" => "HEY"}
    post = posts(:one)
    form = CreateAutoRevisionForExistingContentForm.new(params:, model: post)
    assert form.save!
    assert_equal post.id, form.revision.record_id
    assert_equal post.class.name, form.revision.record_type
    assert form.revision.auto_revision?
    assert_equal params, form.revision.data
  end

  test "should not detect changes if the revision does not differ from the previous revision" do
    params = {"title" => "HEY"}
    post = posts(:two)
    form = CreateAutoRevisionForExistingContentForm.new(params:, model: post)
    assert form.save!
    new_form = CreateAutoRevisionForExistingContentForm.new(params:, model: post)
    assert new_form.save!
    assert new_form.revision.attributes_with_changes.blank?
  end

  test "should detect change when the new revision has additional attributes" do
    params = {"title" => "HEY", "summary" => "HEY"}
    post = posts(:one)
    form = CreateAutoRevisionForExistingContentForm.new(params:, model: post)
    assert form.save!
    params["summary"] = "NOT HEY"
    new_form = CreateAutoRevisionForExistingContentForm.new(params:, model: post)
    assert new_form.save!
    assert_equal ["HEY", "NOT HEY"], new_form.revision.attributes_with_changes["summary"]
  end

  test "should not detect changes in boolean fields if the value is the same" do
    page = pages(:about)
    assert page.main_menu?
    params = page.attributes.merge({"main_menu" => "1"})
    form = CreateAutoRevisionForExistingContentForm.new(params:, model: page)
    assert form.save!

    assert form.revision.attributes_with_changes.blank?
  end
end
