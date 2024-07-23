# frozen_string_literal: true

class Admin::Form::Checkbox::Preview < ApplicationViewComponentPreview
  # You can specify the container class for the default template
  # self.container_class = "w-1/2 border border-gray-300"

  def default
    form = form_with(Page.new)
    render Admin::Form::Checkbox::Component.new(name: :main_menu, form:)
  end
end
