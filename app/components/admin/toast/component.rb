# frozen_string_literal: true

class Admin::Toast::Component < Admin::AdminViewComponent
  option :text, optional: true
  option :event, optional: true
  option :delay, default: -> { 2000 }
end
