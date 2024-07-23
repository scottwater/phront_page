# frozen_string_literal: true

class Admin::Flashed::Component < Admin::AdminViewComponent
  option :notice, optional: true
  option :alert, optional: true
  option :auto_hide_notice, default: -> { true }

  def render?
    (notice || alert) && super
  end
end
