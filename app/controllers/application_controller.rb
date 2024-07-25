# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Auth::Authenticate

  private

  def paging_id
    (params[:page] || 1)&.to_i
  end
end
