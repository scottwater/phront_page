# frozen_string_literal: true

class ApplicationService
  extend Dry::Initializer
  attr_accessor :attributes

  def initialize(*, **options)
    super
    defined_option_keys = self.class.dry_initializer.options.map(&:source)
    self.attributes = options.except(*defined_option_keys)
  end

  def self.call(**)
    new(**).call
  end

  def call
    "CALLING #{self.class}"
  end
end
