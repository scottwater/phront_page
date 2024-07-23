# frozen_string_literal: true

require "test_helper"

class Admin::Form::Checkbox::ComponentTest < ViewComponent::TestCase
  def test_renders_a_checkbox
    component = build_component
    render_inline(component)
    assert_selector("input[type=checkbox]")
    assert_selector("label", text: "Main menu")
  end

  def test_renders_a_custom_label
    component = build_component(label: "Custom label")
    render_inline(component)
    assert_selector("label", text: "Custom label")
  end

  private

  def build_component(**)
    form = form_with(Page.new)
    Admin::Form::Checkbox::Component.new(name: :main_menu, form:, **)
  end

  # def form_with(object, options = {})
  #   object_name = options[:as] || object.class.name.underscore
  #   ActionView::Helpers::FormBuilder.new(object_name, object, template, options)
  # end

  # def template
  #   lookup_context = ActionView::LookupContext.new(ActionController::Base.view_paths)

  #   ActionView::Base.new(lookup_context, {}, ApplicationController.new)
  # end
end
