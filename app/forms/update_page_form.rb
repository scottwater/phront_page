class UpdatePageForm < ApplicationForm
  attr_reader :revision
  option :revision_model_id, optional: true
  option :page

  def update
    page.update(params).tap do |updated|
      if updated
        create_revision
        remove_orphaned_auto_revisions
      end
    end
  end

  private

  def create_revision
    @revision = Revision.create!(record: page, revision_type: :published, data: page.attributes, attributes_with_changes: page.changes)
  end

  def remove_orphaned_auto_revisions
    Revision.where(record: page, revision_type: :auto).delete_all
  end
end
