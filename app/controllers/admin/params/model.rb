module Admin::Params::Model
  extend ActiveSupport::Concern
  include Admin::Params::Post
  include Admin::Params::Page

  def model
    if params[:post]
      @post = Post.new(post_params).tap do |post|
        post.author = Current.author
        post.valid?
      end
    elsif params[:page]
      @page = Page.new(page_params).tap do |page|
        page.valid?
      end
    else
      raise "No model type specified"
    end
  end
end
