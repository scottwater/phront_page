module Admin::Params::Post
  extend ActiveSupport::Concern

  def post_params
    params.require(:post).permit(:markdown, :html, :template, :slug, :og_image_url, :image_url, :description, :title, :author_id, :page_id, :published_at, :summary)
  end
end
