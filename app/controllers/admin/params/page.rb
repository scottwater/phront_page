module Admin::Params::Page
  extend ActiveSupport::Concern

  def page_params
    params.require(:page).permit(:name, :markdown, :html, :template, :slug, :main_menu, :og_image_url, :image_url, :description, :title, :exclude_posts_from_home_page)
  end
end
