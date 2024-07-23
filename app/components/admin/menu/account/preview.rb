# frozen_string_literal: true

class Admin::Menu::Account::Preview < ApplicationViewComponentPreview
  # You can specify the container class for the default template
  # self.container_class = "w-1/2 border border-gray-300"

  def default
    skip_preview("Need to figure out how to pass current session further down the statck")
    # with_current_author do
    #   component = Admin::Menu::Account::Component.new
    #   render(component)
    # end
  end
end
