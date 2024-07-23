# frozen_string_literal: true

class Admin::Form::TextArea::Preview < ApplicationViewComponentPreview
  # This component has an autogrow controller attached.

  def default
    render(Admin::Form::TextArea::Component.new(name: :description, rows: 5, form: form_with(Page.new), wrapped_class: "w-96", label: "Description", help: "The content of the page"))
  end
end
