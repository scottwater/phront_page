# frozen_string_literal: true

class Admin::Form::Select::Preview < ApplicationViewComponentPreview
  # You can specify the container class for the default template
  # self.container_class = "w-1/2 border border-gray-300"

  def default
    render(Admin::Form::Select::Component.new(wrapped_class: "w-96", name: :page_id, label: "Parent Page", choices: Page.pluck(:name, :id).insert(0, ["No Page", -1]), form: form_with(Post.new)))
  end
end
