# frozen_string_literal: true

class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts
  def index
    post_query = params[:q].present? ? Post.search(params[:q]) : Post.ordered
    @posts_data = post_query.paged(paging_id:)
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.published_at = Time.current
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.author = Current.author

    if @post.save
      redirect_to posts_path, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post was successfully updated.", status: :see_other
    else
      if @post.valid?
        flash.now[:alert] = "There was an error updating your post"
      end
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!
    redirect_to posts_url, notice: "Post was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:markdown, :html, :template, :slug, :og_image_url, :image_url, :description, :title, :author_id, :page_id, :published_at, :summary)
  end
end
