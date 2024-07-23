# frozen_string_literal: true

class Admin::Flashed::Preview < ApplicationViewComponentPreview
  # @param alert text "Message to display"
  def alert(alert: "Error!")
    render(Admin::Flashed::Component.new(alert:))
  end

  # @param auto_hide_notice toggle "Whether to auto-hide the notice"
  def notice(auto_hide_notice: false)
    render(Admin::Flashed::Component.new(notice: "Not an error!", auto_hide_notice:))
  end
end
