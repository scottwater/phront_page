class RemoveOrphanedRevisionJob < ApplicationJob
  queue_as :default

  def perform(revision_id)
    revision = Revision.find_by(id: revision_id)
    if revision && revision.record_id.nil?
      revision.destroy!
    end
  end
end
