# frozen_string_literal: true

class Admin::FirstRunController < Admin::BaseController
  layout "blank"
  skip_before_action :authenticate, only: %i[new create]
  before_action :verify_first_run_enabled

  def new
  end

  def create
    if create_author_and_session
      redirect_to admin_root_path, notice: "Your account has been created and you are now logged in."
    else
      flash.alert = "There was an error creating your account. Please try again (is your password too short?)"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def verify_first_run_enabled
    raise "First run is not enabled" unless Author.first_run_safe?
  end

  def create_author_and_session
    if params[:email].present? && params[:password].present?
      author = Author.new(email: params[:email], password: params[:password])
      if params[:time_zone].present?
        author.time_zone = TimeZones.browser_time_zone_to_rails(params[:time_zone])
      end
      if author.save
        session = author.sessions.create!
        Current.session = session
        if params[:remember_me] == "1"
          cookies.signed.permanent[:phront_page_session_token] = {value: session.id, httponly: true}
        else
          cookies.signed[:phront_page_session_token] = {value: session.id, httponly: true}
        end
      end
    end
  end
end
