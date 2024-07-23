# frozen_string_literal: true

class Admin::ModelList::Preview < ApplicationViewComponentPreview
  # You can specify the container class for the default template
  self.container_class = "mt-40 pt-40"
  layout "blank"

  def default
    redirects = Redirect.limit(20)
    component = Admin::ModelList::Component.new(button_text: "New Redirect", button_url: "#")
    component.with_header(title: "From")
    component.with_header(title: "To")
    redirects.each do |redirect|
      component.with_row do |row|
        row.with_cell.with_content(redirect.from)
        row.with_cell.with_content(redirect.to)
        row.with_action(text: "Test", url: redirect.from)
        row.with_action(text: "Edit", url: "#")
      end
    end
    render(component)
  end
end
