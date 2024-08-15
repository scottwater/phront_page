class Revision < ApplicationRecord
  belongs_to :record, polymorphic: true, optional: true
  after_create_commit :remove_orphaned_revision, if: -> { record_id.nil? && uid.present? }
  after_create_commit :prune_revisions, if: :published_revision?
  enum :revision_type, %w[auto published].index_by(&:itself), suffix: :revision
  validate :json_data_is_valid_json

  scope :orphaned_summary, ->(record_type) { select(:record_type, :uid).where(record_type:, record_id: nil).group(:record_type, :uid).to_a }
  scope :orphaned_posts, -> { orphaned_summary("Post") } # .to_a
  scope :orphaned_pages, -> { orphaned_summary("Page") } # .to_a
  scope :orphaned_items_last, ->(record_type:) {
    where(record_type:, record_id: nil)
      .group(:uid)
      .having("id = MAX(id)")
      .order(created_at: :desc)
  }

  private

  def json_data_is_valid_json
    if data.present? && !data.is_a?(Hash)
      errors.add(:data, "must be a hash")
    end

    if attributes_with_changes.present? && !attributes_with_changes.is_a?(Hash)
      errors.add(:data, "must be a hash")
    end
  end

  def remove_orphaned_revision
    RemoveOrphanedRevisionJob.set(wait: 7.days).perform_later(id)
  end

  def prune_revisions
    revisions_to_keep = Revision.where(record: record, revision_type: :published)
      .order(created_at: :desc)
      .limit(10)
      .pluck(:id)

    Revision.where(record: record, revision_type: :published)
      .where.not(id: revisions_to_keep)
      .destroy_all
  end
end
