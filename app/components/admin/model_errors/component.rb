# frozen_string_literal: true

class Admin::ModelErrors::Component < Admin::AdminViewComponent
  option :model
  option :name, default: proc { model.model_name.name.titleize }

  def render?
    model.errors.any? && super
  end
end
