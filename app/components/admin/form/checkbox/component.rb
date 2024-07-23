# frozen_string_literal: true

class Admin::Form::Checkbox::Component < Admin::Form::BaseComponent
  erb_template <<~TEMPLATE
    <div class="<%= merge_wrapped_class("flex items-center justify-between") %>">
      <div class="flex items-start">
        <div class="flex items-center h-5">
          <%= form.check_box name, **attributes, class: "w-5 h-5 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-primary-600 dark:ring-offset-gray-800" %>
        </div>
        <div class="ml-3 text-sm">
          <%= form.label name, label, class: "text-sm font-medium text-gray-900 dark:text-white" %>
          <%= c 'admin/form/help', help: %>
        </div>
      </div>
    </div>
  TEMPLATE
end
