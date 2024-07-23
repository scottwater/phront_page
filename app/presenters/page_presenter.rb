class PagePresenter < Keynote::Presenter
  presents :page

  def title
    page.title.presence || page.name
  end

  def html
    page&.html&.html_safe
  end
end
