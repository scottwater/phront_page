# frozen_string_literal: true

class NotReservedPathValidator < ActiveModel::EachValidator
  RESERVED_PREFIXES = ["/rails/", "/blobs", "/admin"].freeze

  def validate_each(record, attribute, value)
    return unless value.is_a?(String)

    if RESERVED_PREFIXES.any? { |prefix| value.start_with?(prefix) }
      prefix = RESERVED_PREFIXES.find { |prefix| value.start_with?(prefix) }
      record.errors.add(attribute, options[:message] || "cannot start with reserved path '#{prefix}'")
    end
  end
end
