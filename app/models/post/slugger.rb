# frozen_string_literal: true

module Post::Slugger
  extend ActiveSupport::Concern

  included do
    before_validation :slugify
  end

  def truncate_raw_slug(raw_slug)
    raw_slug.truncate(50, omission: "", separator: " ").strip
  end

  def slugify
    if page_id_changed? && (previous_page = Page.find_by(id: page_id_was))
      self.slug = slug.sub(previous_page.slug, "")
    end
    # if page slug exists, remove temporarily remove it
    self.slug = slug.sub(page.slug, "") if page && slug&.start_with?(page.slug)

    self.slug = truncate_raw_slug(slug.presence || title.presence || SecureRandom.alphanumeric(5).downcase).parameterize

    self.slug = "#{page.slug}/#{slug}" if page

    return if slug.starts_with?("/")

    self.slug = "/#{slug}"
  end
end
