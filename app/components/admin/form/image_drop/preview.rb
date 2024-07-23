# frozen_string_literal: true

class Admin::Form::ImageDrop::Preview < ApplicationViewComponentPreview
  # You can specify the container class for the default template
  # self.container_class = "w-1/2 border border-gray-300"

  # @param label text "Image"
  # @param help text "Any image will do"
  def default(label: "Image", help: "Any image will do")
    render(Admin::Form::ImageDrop::Component.new(name: :image, label:, help:, form: form_with(Page.new)))
  end
end
