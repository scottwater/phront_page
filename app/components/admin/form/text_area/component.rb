# frozen_string_literal: true

class Admin::Form::TextArea::Component < Admin::Form::BaseComponent
  option :rows, default: proc { 8 }
end
