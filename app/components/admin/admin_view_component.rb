# frozen_string_literal: true

class Admin::AdminViewComponent < ApplicationViewComponent
  def current_author
    Current.author
  end

  def current_session
    Current.session
  end
end
