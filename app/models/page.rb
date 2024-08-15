# frozen_string_literal: true

class Page < ApplicationRecord
  include Redirect::Content
  enum :page_type, %w[home search content].index_by(&:itself), suffix: :page, default: :content
  validates :name, presence: true, uniqueness: true
  validates :title, presence: true
  validates :template, presence: true, inclusion: {in: Pages.component_list}
  validates :slug, presence: true, not_reserved_path: true, uniqueness: true, format: {with: /\A\/.*\z/,
                                                                                       message: "Slug must start with /"}
  validates :page_type, presence: true
  validates :page_type, uniqueness: true, if: -> { home_page? || search_page? }
  normalizes :og_image_url, :image_url, :description, :title, :template, with: ->(value) { value.blank? ? nil : value }
  normalizes :markdown, :description, with: ->(value) { value&.gsub("\r\n", "\n") }
  has_many :posts
  has_many :revisions, as: :record, dependent: :destroy
  # overrides default ordering in ApplicationRecord
  scope :ordered, -> { order(:name) }
  scope :home_page, -> { find_sole_by(page_type: :home) }
  scope :search_page, -> { find_sole_by(page_type: :search) }
  scope :content_pages, -> { where(page_type: :content) }
  scope :navigation, -> { where(main_menu: true, page_type: :content).ordered }

  def deletable?
    page_type == "content"
  end

  before_destroy do
    raise "Cannot " unless content_page?
  end
  before_validation do
    self.html = markdown&.strip&.present? ? Content::Markdown.to_html(markdown) : nil
    self.title = name if title.blank?
    if home_page?
      self.slug = "/"
    elsif search_page?
      self.slug = "/search"
    elsif slug.blank?
      self.slug = name&.parameterize
    end

    unless slug&.starts_with?("/")
      self.slug = "/#{slug}"
    end
  end

  def template
    self[:template] ||= "blog/pages/traditional"
  end
end
