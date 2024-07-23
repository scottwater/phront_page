# frozen_string_literal: true

class Admin::Form::Wrapper::Preview < ApplicationViewComponentPreview
  def default
    render(Admin::Form::Wrapper::Component.new(title: "I need to figure out how to set up templates for this preview to be useful"))
  end
end
