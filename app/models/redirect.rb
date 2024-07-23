class Redirect < ApplicationRecord
  normalizes :from, with: ->(value) { "/#{value}".gsub("//", "/") }
  normalizes :to, with: ->(value) { value.starts_with?("http") ? value.strip : "/#{value}".gsub("//", "/") }

  validates :from, presence: true, uniqueness: true
  validates :to, presence: true
end
