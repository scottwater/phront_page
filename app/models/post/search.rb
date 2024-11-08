# frozen_string_literal: true

module Post::Search
  extend ActiveSupport::Concern

  included do
    # Temporary until we have a proper search solution
    scope :search, ->(query) { where("title LIKE ?", "%#{query}%") }
  end
end
