# frozen_string_literal: true

class Admin::Form::Button::Component < Admin::AdminViewComponent
  option :type, default: proc { "submit" }
  option :text, default: proc { "Submit" }
  option :button_type, default: proc { "narrow" }
  option :model, optional: true

  def call
    if button_type == "narrow"
      tag.button(type: type, class: "text-white bg-primary-600 hover:bg-primary-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800", **attributes.except(:class, :type)) { content }
    elsif button_type == "wide"
      tag.button(type: type, class: "inline-flex items-center md:px-5 px-4 md:py-2.5 py-2 mt-4 sm:mt-6 md:text-sm text-xs font-medium text-center text-white bg-primary-700 rounded-lg focus:ring-4 focus:ring-primary-200 dark:focus:ring-primary-900 hover:bg-primary-800", **attributes.except(:class, :type)) { content }
    elsif button_type == "secondary"
      tag.button(type: type, class: "inline-flex items-center md:px-5 px-4 md:py-2.5 py-2 mt-4 sm:mt-6 md:text-sm text-xs font-medium text-center text-white bg-slate-700 rounded-lg focus:ring-4 focus:ring-primary-200 dark:focus:ring-primary-900 hover:bg-slate-800", **attributes.except(:class, :type)) { content }

    end
  end

  def content
    text.presence || model_content || super
  end

  def model_content
    return unless model
    type_of_action = model.new_record? ? "Create" : "Update"
    "#{type_of_action} #{model.class.model_name.human}"
  end

  # erb_template <<~TEMPLATE
  #   <button
  #     type="<%= type %>"
  #     class="w-full text-white bg-primary-600 hover:bg-primary-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800"
  #   ><%= text %></button>
  # TEMPLATE
end
