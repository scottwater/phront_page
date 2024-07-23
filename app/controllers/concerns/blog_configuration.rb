module BlogConfiguration
  extend ActiveSupport::Concern
  included do
    before_action :set_blog_config
  end

  def set_blog_config
    Current.blog_config ||= Config::Blog.new
  end

  def current_blog_config
    Current.blog_config
  end
end
