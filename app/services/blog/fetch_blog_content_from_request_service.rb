# frozen_string_literal: true

class Blog::FetchBlogContentFromRequestService < ApplicationService
  option :slug
  option :redirected, optional: true, default: proc { 0 }
  attr_reader :page, :post, :redirect

  def call
    unless slug.starts_with?("/")
      slug.prepend("/")
    end
    find_and_set_page || find_and_set_post || find_and_set_redirect
  end

  private

  def still_ok_to_redirect?
    redirected <= 5
  end

  def find_and_set_page
    @page = Page.find_by(slug: slug)
  end

  def find_and_set_post
    @post = Post.published.find_by(slug: slug)
  end

  def find_and_set_redirect
    (@redirect = Redirect.find_by(from: slug)) if still_ok_to_redirect?
  end
end
