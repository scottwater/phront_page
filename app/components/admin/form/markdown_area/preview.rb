# frozen_string_literal: true

class Admin::Form::MarkdownArea::Preview < ApplicationViewComponentPreview
  # This element has an autogrow controller attached.
  # It supports drag and file uploads.
  # @param label text "Label for the markdown area"
  # @param help text "Help text for the markdown area"
  def default(label: "Body", help: "Write in markdown. Drag and Drop images!")
    render(Admin::Form::MarkdownArea::Component.new(name: :body, label: label, help: help, form: form_with(Page.new), wrapped_class: "w-full mx-16 max-w-2xl"))
  end
end
