class Admin::Form::BaseComponent < Admin::AdminViewComponent
  option :name
  option :form
  option :label, default: proc { name.to_s.humanize }
  option :value, optional: true
  option :help, optional: true

  def value
    return super unless form&.object

    form.object[name] || super
  end

  def uploaded_assets_base_path
    asset_path = ENV["UPLOADED_ASSET_BASE_PATH"]
    if asset_path.present?
      URI.join(asset_path, ENV.fetch("UPLOAD_PREFIX", "/")).to_s
    end
  end
end
