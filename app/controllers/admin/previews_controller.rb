class Admin::PreviewsController < Admin::BaseController
  include Admin::Params::Post
  include Admin::Params::Page
  def show
    if params[:post]
      @post = Post.new(post_params)
      @post.author = Current.author
      @post.valid? # Is there a better way to force the callbacks?
      render :post
    elsif params[:page]
      @page = Page.new(page_params)
      @page.valid? # Is there a better way to force the callbacks?
      render :page
    else
      raise "No preview type specified"
    end
  end
end
