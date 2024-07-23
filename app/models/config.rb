class Config < ApplicationRecord
  validates :key, presence: true, uniqueness: true
  normalizes :key, with: ->(value) { value.parameterize }

  def typed_store_keys
    if self.class.respond_to?(:typed_stores)
      self.class.typed_stores[:data].fields.keys
    else
      []
    end
  end

  # This will block any derived classes from doing bulk updates
  default_scope { where(key:) }

  before_validation do
    self[:key] = self.class.name.parameterize
  end

  after_initialize do
    self[:key] ||= self.class.name.parameterize
  end

  def key
    self.class.name.parameterize
  end

  def self.key
    name.parameterize
  end

  def self.fetch
    find_by(key:) || new(key:)
  end

  def self.get(key)
    "config/#{key}".camelize.constantize.fetch
  end
end
