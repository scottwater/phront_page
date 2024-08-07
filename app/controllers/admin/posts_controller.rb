# frozen_string_literal: true

class Admin::PostsController < Admin::BaseController
  include Admin::Params::Post
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_form_type, only: %i[new create edit update]

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
    @post.markdown = generate_default_post_markdown if @form_type == "popup"
    @post.published_at = Time.current
    render layout: (@form_type == "popup") ? "blank" : "admin"
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.author = Current.author

    if @post.save
      if @form_type == "popup"
        flash.now.notice = "Post was successfully created."
        render :create_success, layout: "blank", status: :created
      else
        redirect_to posts_path, notice: "Post was successfully created."
      end
    else
      render :new, status: :unprocessable_entity, layout: (@form_type == "popup") ? "blank" : "admin"
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

  def generate_default_post_markdown
    title, url, body = params[:title], params[:url], params[:body]
    content = []
    if title.present? && url.present?
      content << "[#{title}](#{url})"
    end

    if body.present?
      content << "> #{body}"
    end

    content.any? ? content.join("\n\n") : nil
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_form_type
    @form_type = params[:form_type]
  end
end
