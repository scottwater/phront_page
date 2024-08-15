class Admin::RevisionsController < Admin::BaseController
  include Admin::Params::Post
  include Admin::Params::Page
  before_action :set_revision_model_id

  def show
    revision_model_id = params[:revision_model_id]
    revision_type = params[:revision_type].classify
    revisions = if revision_model_id.match?(/^\d+$/)
      Revision.where(record_type: revision_type, record_id: revision_model_id)
    else
      Revision.where(record_type: revision_type, uid: revision_model_id)
    end
    revisions = revisions.order(created_at: :desc).limit(10)
    render turbo_stream: turbo_stream.update("revisions", Admin::Revisions::Component.new(revisions:))
  end

  def create_for_new
    if params[:post]
      CreateAutoRevisionForNewContentForm.new(params: post_params, model_type: Post, revision_model_id:).save!
    elsif params[:page]
      CreateAutoRevisionForNewContentForm.new(params: page_params, model_type: Page, revision_model_id:).save!
    else
      raise "Invalid model type"
    end

    render_success_toast
  end

  def create_for_existing
    if params[:post]
      CreateAutoRevisionForExistingContentForm.new(
        # Author is not set on form. Ensure it does not affect the revision
        params: post_params.merge(author_id: Current.author.id),
        model: Post.find(revision_model_id)
      ).save!
    elsif params[:page]
      CreateAutoRevisionForExistingContentForm.new(
        params: page_params,
        model: Page.find(revision_model_id)
      ).save!
    else
      raise "Invalid model type"
    end
    render_success_toast
  end

  private

  def render_success_toast
    render turbo_stream: turbo_stream.append_all("body", Admin::Toast::Component.new(text: "Your changes have been saved"))
  end

  def set_revision_model_id
    @revision_model_id = params[:revision_model_id]
  end

  def revision_model_id
    params[:revision_model_id]
  end
end
