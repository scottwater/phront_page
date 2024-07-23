class ApplicationViewComponent < ViewComponentContrib::Base
  extend Dry::Initializer
  include ApplicationHelper
  include ViewComponentContrib::StyleVariants

  attr_accessor :attributes

  option :display, default: proc { true }
  option :wrapped_class, default: proc { "" }

  def initialize(*, **options)
    super
    defined_option_keys = self.class.dry_initializer.options.map(&:source)
    self.attributes = options.except(*defined_option_keys)
  end

  def render?
    display
  end

  style_config.postprocess_with do |classes|
    TailwindMerge::Merger.new.merge(classes.join(" "))
  end

  def merge_wrapped_class(initialized_classes = nil)
    if wrapped_class
      TailwindMerge::Merger.new.merge([initialized_classes, wrapped_class])
    else
      initialized_classes
    end
  end

  def merged_classes_class_attribute(initialized_classes = nil)
    if (klasses = merge_wrapped_class(initialized_classes))
      "class='#{klasses}'".html_safe
    else
      ""
    end
  end

  def stimulus_target
    "#{stimulus_controller}-target"
  end

  def stimulus_value(name)
    "#{stimulus_controller}-#{name}-value"
  end

  def stimulus_controller
    self.class.stimulus_controller
  end

  def self.stimulus_controller
    name.underscore.dasherize.gsub("/", "--")
  end
end
