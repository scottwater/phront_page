# frozen_string_literal: true

class Blog::Head::Component < Blog::BlogViewComponent
  def title
    @title ||= if Current.page
      "#{Current.page.title} | #{meta.title}"
    elsif current_post
      "#{current_post.title} | #{meta.title}"
    else
      meta.title
    end
  end

  def description
    @description ||= if current_page
      current_page.description
    elsif current_post
      current_post.description.presence || current_post.summary
    end
  end

  def url
    @url ||= "#{Current.blog_config.settings.base_url}#{(current_page || current_post)&.slug}"
  end

  def feed_url(format = :json)
    "#{Current.blog_config.settings.base_url}/feed.#{format}"
  end

  def og_image_url
    @og_image_url ||= (current_page || current_post)&.og_image_url || meta.og_image_url
  end
end
