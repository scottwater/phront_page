# frozen_string_literal: true

class Admin::ModelErrors::Preview < ApplicationViewComponentPreview
  # @param model_klass select [Post, Page, Redirect, Config::Blog::Meta] "The class name of the model to be created"
  def default(model_klass: "Post")
    model = model_klass.constantize.new
    model.save
    render(Admin::ModelErrors::Component.new(model:))
  end
end
