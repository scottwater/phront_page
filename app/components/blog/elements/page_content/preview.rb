# frozen_string_literal: true

class Blog::Elements::PageContent::Preview < ApplicationViewComponentPreview
  def default
    html = Content::Markdown.to_html(Faker::Markdown.sandwich(sentences: 15))
    render(Blog::Elements::PageContent::Component.new(page: Page.new(title: "Page Title", html: html, slug: "/page-slug"), next: false))
  end
end
