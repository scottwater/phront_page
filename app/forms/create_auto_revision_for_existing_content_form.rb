class CreateAutoRevisionForExistingContentForm < ApplicationForm
  attr_reader :revision
  option :model

  def save!
    changes = detect_changes
    @revision = Revision.create!(
      record_type: model.class,
      record_id: model.id,
      revision_type: :auto,
      data: params.select { |key, value| value.present? },
      attributes_with_changes: changes
    )
  end

  private

  def detect_changes
    previous_data = previous_revision&.data || model.attributes
    params_with_data = keys_with_data(params)
    keys_with_data = filter_keys_with_data(previous_data, params_with_data)
    {}.tap do |changed_keys|
      keys_with_data.each do |key|
        changes = case model.class.columns_hash[key]&.type
        in :boolean
          boolean_changes(previous_data[key], params[key])
        in :text
          text_changes(previous_data[key], params[key])
        in :datetime
          datetime_changes(previous_data[key], params[key])
        else
          changes_for_field(previous_data[key], params[key])
        end
        changed_keys[key] = changes if changes
      end
    end
  end

  def filter_keys_with_data(previous_data, params_with_data)
    Set.new(keys_with_data(previous_data)).tap do |keys_with_data|
      keys_with_data.merge(params_with_data, params_with_data)
      keys_with_data.delete_if { |key| %w[id html page_type author_id created_at updated_at].include?(key) }
    end
  end

  def datetime_changes(previous_value, new_value)
    [previous_value, new_value] if DateTime.parse(previous_value) != DateTime.parse(new_value)
  end

  def boolean_changes(previous_value, new_value)
    [previous_value, new_value] if to_boolean_string(previous_value) != to_boolean_string(new_value)
  end

  def text_changes(previous_value, new_value)
    # In the models we normalize these changes, but since we are not using the model here
    # we need to do the normalization here
    previous_field = normalize_text_field(previous_value)
    new_field = normalize_text_field(new_value)
    [previous_field, new_field] if previous_field != new_field
  end

  def changes_for_field(previous_value, new_value)
    [previous_value, new_value] if previous_value != new_value
  end

  def to_boolean_string(value)
    value.to_s.downcase.in?(["true", "1"]) ? "true" : "false"
  end

  def normalize_text_field(value)
    value&.gsub("\r\n", "\n")
  end

  def keys_with_data(hash)
    hash.keys.select { |key| hash[key].present? }
  end

  def previous_revision
    unless defined?(@previous_revision)
      # First look for an auto revision for the current model
      @previous_revision = Revision.where(record_type: model.class.name, revision_type: :auto, record_id: model.id).order(created_at: :desc).first
      # If there is no auto revision, look for a published revision
      @previous_revision ||= Revision.where(record_type: model.class.name, revision_type: :published, record_id: model.id).order(created_at: :desc).first
    end
    @previous_revision
  end
end
