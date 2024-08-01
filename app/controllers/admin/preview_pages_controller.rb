class Admin::PreviewPagesController < Admin::BaseController
  def show
    @page = Page.new(page_params)
    @page.valid? # Is there a better way to force the callbacks?
  end

  private

  def page_params
    params.require(:page).permit(:name, :markdown, :html, :template, :slug, :main_menu, :og_image_url, :image_url, :description, :title, :exclude_posts_from_home_page)
  end
end
