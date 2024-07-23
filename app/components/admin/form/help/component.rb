# frozen_string_literal: true

class Admin::Form::Help::Component < Admin::AdminViewComponent
  option :help

  def render?
    help.present?
  end

  erb_template <<~TEMPLATE
    <p id="helper-text-explanation" class="my-1 text-sm text-gray-500 dark:text-gray-400"><%= content || help %></p>
  TEMPLATE
end
