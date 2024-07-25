# frozen_string_literal: true

class Admin::SessionsController < Admin::BaseController
  layout "blank"
  skip_before_action :authenticate, only: %i[new create]

  before_action :set_session, only: :destroy

  def index
    @sessions = Current.author.sessions.order(created_at: :desc)
  end

  def new
    if Author.first_run_safe?
      redirect_to first_run_path
    else
      render :new
    end
  end

  def create
    if (author = Author.authenticate_by(email: params[:email], password: params[:password]))
      @session = author.sessions.create!
      if params[:remember_me] == "1"
        cookies.signed.permanent[:phront_page_session_token] = {value: @session.id, httponly: true}
      else
        cookies.signed[:phront_page_session_token] = {value: @session.id, httponly: true}
      end

      redirect_to session[:return_to] || admin_root_path, notice: "Signed in successfully"
    else
      redirect_to sign_in_path(email_hint: params[:email]), alert: "That email or password is incorrect"
    end
  end

  def destroy
    @session.destroy
    redirect_to(admin_root_path, notice: "That session has been logged out")
  end

  private

  def set_session
    @session = Current.author.sessions.find(params[:id])
  end
end
