# frozen_string_literal: true

class Post < ApplicationRecord
  include Redirect::Content
  include Content
  include Slugger
  include Search
  belongs_to :author
  belongs_to :page, optional: true
  has_many :revisions, as: :record, dependent: :destroy
  validates :markdown, presence: true
  validates :html, presence: true
  validates :slug, presence: true, uniqueness: true, not_reserved_path: true, format: {with: /\A\/.*\z/,
                                                                                       message: "Slug must start with /"}
  scope :published, -> { where.not(published_at: nil).where("published_at <= :now", now: Time.current) }
  scope :home_page, -> {
                      left_joins(:page)
                        .where("posts.page_id IS NULL OR pages.exclude_posts_from_home_page = ?", false)
                        .published
                    }
  scope :root_feed, ->(limit = 20) { home_page.ordered.limit(limit) }
  normalizes :page_id, with: ->(page_id) { (page_id.to_i <= 0) ? nil : page_id }
  normalizes :og_image_url, :image_url, :description, :title, :summary, with: ->(value) { value.blank? ? nil : value }
  normalizes :markdown, :summary, :description, with: ->(value) { value&.gsub("\r\n", "\n") }
end
