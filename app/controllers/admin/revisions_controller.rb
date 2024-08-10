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
      create_new_revision(Post, post_params)
    elsif params[:page]
      create_new_revision(Page, page_params)
    else
      raise "Invalid model type"
    end

    render_success_toast
  end

  def create_for_existing
    if params[:post]
      create_existing_revision(Post, post_params)
    elsif params[:page]
      create_existing_revision(Page, page_params)
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

  def update_existing_model(model, update_params)
    update_params.each do |key, value|
      model.send(:"#{key}=", value)
    end
  end

  def create_new_revision(model_type, model_params)
    create_revision(model_type.new(model_params), @revision_model_id)
  end

  def create_existing_revision(model_type, model_params)
    model_instance = model_type.find(@revision_model_id).tap do |model|
      model_params.each do |key, value|
        model.send(:"#{key}=", value)
      end
    end
    create_revision(model_instance, nil)
  end

  def create_revision(model, uid)
    if model.respond_to?(:author=)
      model.author = Current.author
    end
    model.valid?
    if model.new_record?
      # For revisions on new records, we do not want the model to be persisted
      # directly in the database. Calling create! with record: model and the relationship
      # defined on the model will cause the record to be persisted.
      Revision.create!(record_type: model.class.name, revision_type: :auto, data: model.attributes, attributes_with_changes: model.changes, uid:)
    else
      Revision.create!(record: model, revision_type: :auto, data: model.attributes, attributes_with_changes: model.changes, uid:)
    end
  end
end
