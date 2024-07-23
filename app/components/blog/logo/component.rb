# frozen_string_literal: true

class Blog::Logo::Component < Blog::BlogViewComponent
  option :name, default: -> { "PhrontPage" }
  option :logo, optional: true

  def logo?
    logo.present?
  end
end
