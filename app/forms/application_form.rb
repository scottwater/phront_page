class ApplicationForm
  extend Dry::Initializer
  attr_accessor :attributes

  option :params

  def initialize(*, **options)
    super
    defined_option_keys = self.class.dry_initializer.options.map(&:source)
    self.attributes = options.except(*defined_option_keys)
  end
end
