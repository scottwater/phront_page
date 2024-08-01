class Admin::PreviewPostsController < Admin::BaseController
  def show
    @post = Post.new(post_params)
    @post.author = Current.author
    @post.valid? # Is there a better way to force the callbacks?
  end

  private

  def post_params
    params.require(:post).permit(:markdown, :html, :template, :slug, :og_image_url, :image_url, :description, :title, :author_id, :page_id, :published_at, :summary)
  end
end
