class Admin::AdminViewComponent < ApplicationViewComponent
  include Admin::AdminHelper

  def current_author
    Current.author
  end

  def current_session
    Current.session
  end
end
