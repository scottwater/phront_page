# frozen_string_literal: true

class Admin::Form::Text::Component < Admin::Form::BaseComponent
  erb_template <<~TEMPLATE
    <div <%= merged_classes_class_attribute %>>
      <%= form.label name, label, class: "block mb-2 text-sm font-medium text-gray-900 dark:text-white" %>
      <%= form.text_field name, class: "bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500", value: value, **attributes %>
      <%= c 'admin/form/help', help: %>
    </div>
  TEMPLATE
end
