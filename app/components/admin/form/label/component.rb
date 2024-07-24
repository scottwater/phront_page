# frozen_string_literal: true

class Admin::Form::Label::Component < Admin::AdminViewComponent
  option :name
  option :form
  option :label, default: proc { name.to_s.humanize }

  def render?
    label
  end
  erb_template <<~TEMPLATE
    <%= form.label name, label, class: "block mb-2 text-sm font-medium text-gray-900 dark:text-white" %>
  TEMPLATE
end
