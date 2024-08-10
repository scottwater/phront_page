# frozen_string_literal: true

class Admin::PagesController < Admin::BaseController
  include Admin::Revisions::Finder
  include Admin::Params::Page
  before_action :set_page, only: %i[show destroy]

  # GET /pages
  def index
    @pages_data = Page.ordered.paged(paging_id:)
  end

  # GET /pages/1
  def show
  end

  # GET /pages/new
  def new
    if params[:revision]
      new_instance_with_revision(Page)
    else
      @revision_model_id = SecureRandom.uuid
      @page = Page.new
    end
  end

  # GET /pages/1/edit
  def edit
    if params[:revision]
      exsting_instance_with_revision(Page)
    else
      @page = Page.find(params[:id])
    end
  end

  # POST /pages
  def create
    form = CreatePageForm.new(params: page_params, revision_model_id: params[:revision_model_id])

    if form.save
      redirect_to pages_path, notice: "Page was successfully created."
    else
      @page = form.page
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pages/1
  def update
    form = UpdatePageForm.new(params: page_params, page: Page.find(params[:id]))
    if form.update
      redirect_to pages_path, notice: "Page was successfully updated.", status: :see_other
    else
      @page = form.page
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
end
