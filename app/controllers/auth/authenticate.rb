# frozen_string_literal: true

module Auth::Authenticate
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
    before_action :set_current_request_details
    helper_method :logged_in?
  end

  def logged_in?
    Current.author
  end

  def authenticate
    # For now, we will set the current session, but not require it
    # outside of the admin. This may need to be removed from edge
    # caching in the future
    if (session_record = Session.find_by_id(cookies.signed[:phront_page_session_token]))
      Current.session = session_record
    end
  end

  def set_current_request_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end
end
