# frozen_string_literal: true

class Admin::Form::Text::Preview < ApplicationViewComponentPreview
  # You can specify the container class for the default template
  # self.container_class = "w-1/2 border border-gray-300"

  def default
    render(Admin::Form::Text::Component.new(name: :title, form: form_with(Page.new), wrapped_class: "w-96", label: "Title", help: "The title of the page"))
  end
end
