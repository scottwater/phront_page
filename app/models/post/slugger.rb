# frozen_string_literal: true

module Post::Slugger
  extend ActiveSupport::Concern

  included do
    before_validation :slugify
  end

  def truncate_raw_slug(raw_slug)
    raw_slug.truncate(25, omission: "", separator: " ").strip
  end

  def slugify
    if page_id_changed?
      if (previous_page = Page.find_by(id: page_id_was))
        self.slug = slug.sub(previous_page.slug, "")
      end
    end
    # if page slug exists, remove temporarily remove it
    if page && slug&.start_with?(page.slug)
      self.slug = slug.sub(page.slug, "")
    end

    self.slug = truncate_raw_slug(slug.presence || title.presence || SecureRandom.alphanumeric(5).downcase).parameterize

    if page
      self.slug = "#{page.slug}/#{slug}"
    end

    unless slug.starts_with?("/")
      self.slug = "/#{slug}"
    end
  end
end
