# frozen_string_literal: true

module ComponentFormHelpers
  # NOTE: Changes to this file require a server restart.

  def component_image_drop(name, attributes = {}, &)
    label = options.delete(:label) { name.to_s.humanize }
    @template.render Admin::Form::ImageDrop::Component.new(name:, form: self, label:, **attributes, &)
  end

  def component_check_box(name, attributes = {}, &)
    label = options.delete(:label) { name.to_s.humanize }
    @template.render Admin::Form::Checkbox::Component.new(name:, form: self, label:, **attributes, &)
  end

  def component_select(name, choices, attributes = {}, &)
    label = options.delete(:label) { name.to_s.humanize }
    @template.render Admin::Form::Select::Component.new(name:, choices:, form: self, label:, **attributes, &)
  end

  def component_text_area(name, attributes = {}, &)
    label = options.delete(:label) { name.to_s.humanize }
    @template.render Admin::Form::TextArea::Component.new(name:, form: self, label:, **attributes, &)
  end

  def component_markdown_area(name, attributes = {}, &)
    label = options.delete(:label) { name.to_s.humanize }
    @template.render Admin::Form::MarkdownArea::Component.new(name:, form: self, label:, **attributes, &)
  end

  def component_text_field(name, attributes = {}, &)
    component_text(name, :text, attributes, &)
  end

  def component_email_field(name, attributes = {}, &)
    component_text(name, :email, {autocomplete: "email"}.merge(attributes), &)
  end

  def component_password_field(name, attributes = {}, &)
    component_text(name, :password, attributes, &)
  end

  def component_text(name, default_type, attributes = {}, &)
    label = options.delete(:label) { name.to_s.humanize }
    type = options.delete(:type) { default_type }
    @template.render Admin::Form::Text::Component.new(name:, form: self, label: label, type: type, **attributes, &)
  end

  def component_submit_button(attributes = {})
    text = attributes.delete(:text)
    options.delete(:type)
    attributes.delete(:type)
    model = attributes.delete(:model) || object
    @template.render Admin::Form::Button::Component.new(text:, model:, type: :submit, **attributes)
  end

  alias_method :cb, :component_check_box
  alias_method :tf, :component_text_field
  alias_method :pf, :component_password_field
  alias_method :ef, :component_email_field
  alias_method :sb, :component_submit_button
  alias_method :ta, :component_text_area
  alias_method :mda, :component_markdown_area
  alias_method :sf, :component_select
  alias_method :img_drop, :component_image_drop
end
