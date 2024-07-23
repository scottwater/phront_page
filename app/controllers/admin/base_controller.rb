class Admin::BaseController < ApplicationController
  around_action :set_time_zone, if: -> { Current.author&.time_zone }

  layout "admin"

  private

  def set_time_zone(&)
    Time.use_zone(Current.author.time_zone, &)
  end

  def authenticate
    super
    unless Current.session
      session[:return_to] = request.fullpath
      redirect_to sign_in_path
    end
  end
end
