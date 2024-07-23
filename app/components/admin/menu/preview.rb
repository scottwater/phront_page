# frozen_string_literal: true

class Admin::Menu::Preview < ApplicationViewComponentPreview
  def default
    with_current_author(Author.first) do
      render(Admin::Menu::Component.new)
    end
  end
end
