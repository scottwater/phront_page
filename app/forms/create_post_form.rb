class CreatePostForm < ApplicationForm
  attr_reader :post, :revision
  option :author
  option :revision_model_id, optional: true

  def save
    @post = Post.new(params)
    @post.author = author
    @post.save.tap do |saved|
      if saved
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
    if revision_model_id
      Revision.where(uid: revision_model_id, record_type: "Post", revision_type: :auto).delete_all
    end
  end
end
