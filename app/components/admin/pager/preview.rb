# frozen_string_literal: true

class Admin::Pager::Preview < ApplicationViewComponentPreview
  # You can specify the container class for the default template
  # self.container_class = "w-1/2 border border-gray-300"

  def default
    render(Admin::Pager::Component.new(url: "http://example.com?page=2"))
  end
end
