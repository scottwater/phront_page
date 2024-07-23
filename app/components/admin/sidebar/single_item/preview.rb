# frozen_string_literal: true

class Admin::Sidebar::SingleItem::Preview < ApplicationViewComponentPreview
  # @param text text "The text to display"
  # @param icon select ['bug', 'cog', 'home', 'inbox'] "The icon to display"
  # @param url text "The URL
  def default(text: "Hello, World!", icon: :bug, url: "#")
    render(Admin::Sidebar::SingleItem::Component.new(icon:, text:, url:))
  end
end
