# frozen_string_literal: true

class Admin::Form::Wrapper::Component < Admin::AdminViewComponent
  option :model, optional: true
  option :title, optional: true

  def form_title
    title || model_title
  end

  def model_title
    return nil unless model
    type_of_action = model.new_record? ? "New" : "Edit"
    "#{type_of_action} #{model.class.model_name.human}"
  end
end
