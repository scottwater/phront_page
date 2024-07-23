class Admin::RedirectsController < Admin::BaseController
  before_action :set_redirect, only: %i[edit update destroy]

  # GET /redirects
  def index
    @redirect_data = Redirect.ordered.paged(paging_id:)
  end

  # GET /redirects/new
  def new
    @redirect = Redirect.new
  end

  # GET /redirects/1/edit
  def edit
  end

  # POST /redirects
  def create
    @redirect = Redirect.new(redirect_params)

    if @redirect.save
      redirect_to redirects_path, notice: "Redirect was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /redirects/1
  def update
    if @redirect.update(redirect_params)
      redirect_to redirects_path, notice: "Redirect was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /redirects/1
  def destroy
    @redirect.destroy!
    redirect_to redirects_url, notice: "Redirect was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_redirect
    @redirect = Redirect.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def redirect_params
    params.require(:redirect).permit(:from, :to)
  end
end
