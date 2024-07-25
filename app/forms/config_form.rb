# frozen_string_literal: true

class ConfigForm
  extend Dry::Initializer
  attr_accessor :attributes
  attr_reader :model

  option :type_name
  option :model_name
  option :params

  def save
    @model = Config.get("#{type_name}/#{model_name}")
    @model.update(params)
  end
end
