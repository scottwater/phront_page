require "test_helper"

class RemoveOrphanedRevisionJobTest < ActiveJob::TestCase
  test "should enqueue job to remove orphaned revision" do
    assert_enqueued_with(job: RemoveOrphanedRevisionJob, at: 7.days.from_now) do
      Revision.create!(record_type: "Post", record_id: nil, uid: "test", revision_type: :auto)
    end
  end

  test "should remove orphaned revision when job runs" do
    revision = Revision.create!(record_type: "Post", record_id: nil, uid: "test", revision_type: :auto)

    assert_difference "Revision.count", -1 do
      RemoveOrphanedRevisionJob.perform_now(revision.id)
    end

    assert_nil Revision.find_by(id: revision.id)
  end

  test "should NOT remove revisions that belogn to a record" do
    post = posts(:one)
    revision = Revision.create!(record: post, revision_type: :auto)

    assert_no_difference "Revision.count" do
      RemoveOrphanedRevisionJob.perform_now(revision.id)
    end

    assert Revision.find_by(id: revision.id)
  end
end
