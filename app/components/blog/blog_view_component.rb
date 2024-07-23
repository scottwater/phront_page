class Blog::BlogViewComponent < ApplicationViewComponent
  include BlogHelper

  def current_blog_config
    Current.blog_config
  end

  def meta
    current_blog_config.meta
  end

  def settings
    current_blog_config.settings
  end

  def socials
    current_blog_config.socials
  end

  def current_page
    Current.page
  end

  def current_post
    Current.post
  end

  def has_written_content?
    current_page || current_post
  end
end
