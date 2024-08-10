class UpdatePostForm < ApplicationForm
  attr_reader :revision
  option :revision_model_id, optional: true
  option :post

  def update
    post.update(params).tap do |updated|
      if updated
        create_revision
        remove_orphaned_auto_revisions
      end
    end
  end

  private

  def create_revision
    @revision = Revision.create!(record: post, revision_type: :published, data: post.attributes, attributes_with_changes: post.changes)
  end

  def remove_orphaned_auto_revisions
    Revision.where(record: post, revision_type: :auto).delete_all
  end
end
