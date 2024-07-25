# frozen_string_literal: true

class Admin::ConfigurationsController < Admin::BaseController
  helper_method :edit_form_name

  def index
    @configs = [
      {name: :content, title: "Content"},
      {name: :settings, title: "Settings"},
      {name: :meta, title: "Meta Site Content"},
      {name: :socials, title: "Social Networks"}
    ]
  end

  def edit
    @config = current_config_model
  end

  def update
    config_form = ConfigForm.new(type_name: "blog", model_name: params[:id], params: config_params)
    if config_form.save
      redirect_to configurations_path, notice: "#{params[:id].titleize} configurations updated", status: :see_other
    else
      @config = config_form.model
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def edit_form_name
    config_name = params[:id]
    "#{config_name}_form" if Config::Blog.constants.include?(config_name.capitalize.to_sym)
  end

  def config_params = params.require(param_model_name).permit(current_config_model.class.typed_stores[:data].fields.keys)

  def current_config_model = Config.get("blog/#{params[:id]}")

  def param_model_name = current_config_model.class.model_name.param_key
end
