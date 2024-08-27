# frozen_string_literal: true

class Config::Blog::Socials < Config
  typed_store :data, coder: ActiveRecord::TypedStore::IdentityCoder do |s|
    s.string :github_url, blank: false
    s.string :github_username, blank: false
    s.string :instagram_url, blank: false
    s.string :instagram_username, blank: false
    s.string :linked_in_url, blank: false
    s.string :linked_in_username, blank: false
    s.string :mastodon_url, blank: false
    s.string :mastodon_username, blank: false
    s.string :x_url, blank: false
    s.string :x_username, blank: false
    s.string :youtube_url, blank: false
    s.string :youtube_username, blank: false
  end

  before_validation do
    data.select { |key, value| key.ends_with?("_url") }.each do |key, value|
      if value.present? && !value.downcase.starts_with?("http")
        errors.add(key, "must start with http")
      end
    end
  end

  def self.networks
    typed_stores[:data].fields.keys.map { |key| key.to_s.gsub(/_(?:url|username)$/, "") }.uniq
  end

  def networks
    self.class.networks
  end

  def urls
    data.select { |key, value| key.ends_with?("_url") }.values.compact_blank
  end
end
