# frozen_string_literal: true

class Admin::Logo::Preview < ApplicationViewComponentPreview
  def default
    render(Admin::Logo::Component.new)
  end
end
