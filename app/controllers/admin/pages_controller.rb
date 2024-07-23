class Admin::PagesController < Admin::BaseController
  before_action :set_page, only: %i[show edit update destroy]

  # GET /pages
  def index
    @pages_data = Page.ordered.paged(paging_id:)
  end

  # GET /pages/1
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to pages_path, notice: "Page was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pages/1
  def update
    if @page.update(page_params)
      redirect_to pages_path, notice: "Page was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /pages/1
  def destroy
    if @page.content_page?
      @page.destroy!
      redirect_to pages_url, notice: "Page was successfully destroyed.", status: :see_other
    else
      redirect_to pages_url, alert: "This page cannot be deleted." # , status: :see_other
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def page_params
    params.require(:page).permit(:name, :markdown, :html, :template, :slug, :main_menu, :og_image_url, :image_url, :description, :title, :exclude_posts_from_home_page)
  end
end
