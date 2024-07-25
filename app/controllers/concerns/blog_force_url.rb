# frozen_string_literal: true

module BlogForceUrl
  extend ActiveSupport::Concern
  included do
    before_action :ensure_base_url_if_forced
  end

  def ensure_base_url_if_forced
    if force_base_url?
      if !request.url.starts_with?(Current.blog_config.settings.base_url)
        uri = URI.parse(Current.blog_config.settings.base_url)
        uri.path = request.path
        redirect_to uri.to_s, allow_other_host: true
      end
    end
  end

  def force_base_url?
    Current.blog_config&.settings&.force_base_url? && Current.blog_config&.settings&.base_url.present?
  end
end
