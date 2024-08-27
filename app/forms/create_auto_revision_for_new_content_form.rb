class CreateAutoRevisionForNewContentForm < ApplicationForm
  attr_reader :revision
  option :revision_model_id
  option :model_type

  def save!
    changes = detect_changes
    @revision = Revision.create!(record_type: model_type, revision_type: :auto, data: params.compact_blank, attributes_with_changes: changes, uid: revision_model_id)
  end

  private

  def detect_changes
    previous_data = previous_revision&.data || {}
    params_with_data = keys_with_data(params)
    keys_with_data = Set.new(keys_with_data(previous_data))
    keys_with_data.merge(params_with_data)
    {}.tap do |changed_keys|
      keys_with_data.each do |key|
        if previous_data[key] != params[key]
          changed_keys[key] = [previous_data[key], params[key]]
        end
      end
    end
  end

  def keys_with_data(hash)
    hash.keys.select { |key| hash[key].present? }
  end

  def previous_revision
    unless defined?(@previous_revision)
      @previous_revision = Revision.where(record_type: model_type.name, revision_type: :auto, uid: revision_model_id).order(created_at: :desc).first
    end
    @previous_revision
  end
end
