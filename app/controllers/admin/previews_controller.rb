class Admin::PreviewsController < Admin::BaseController
  include Admin::Params::Post
  include Admin::Params::Page
  def show
    if params[:post]
      @post = create_temporary_model(Post, post_params)
      render :post
    elsif params[:page]
      @page = create_temporary_model(Page, page_params)
      render :page
    else
      raise "No preview type specified"
    end
  end

  private

  def create_temporary_model(model_type, model_params)
    model_type.new(model_params).tap do |model|
      model.author = Current.author if model.respond_to?(:author=)
      model.valid?
    end
  end
end
