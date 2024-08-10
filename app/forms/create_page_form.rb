class CreatePageForm < ApplicationForm
  attr_reader :page, :revision
  option :revision_model_id, optional: true

  def save
    @page = Page.new(params)
    @page.save.tap do |saved|
      if saved
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
    if revision_model_id
      Revision.where(uid: revision_model_id, record_type: "Page", revision_type: :auto).delete_all
    end
  end
end
