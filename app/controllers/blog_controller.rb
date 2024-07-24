class BlogController < ApplicationController
  include BlogConfiguration
  include BlogForceUrl

  def show
    case Blog::FetchBlogContentFromRequestService.call(slug:, redirected:)
    in Page => current_page
      Current.page = current_page
      render Blog::HandlePageRequestService.new(page: current_page, paging_id:, search_query:).call
    in Post => post
      Current.post = post
      render Blog::Posts::Default::Component.new(post:)
    in Redirect => redirect
      redirect_to "#{redirect.to}?redirected=#{redirected}", status: :moved_permanently
    else
      render Blog::MissingContent::Component.new, status: :not_found
    end
  end

  private

  def slug
    # the slug param does not include the format
    # if we want to handle redirects from .htm and .html
    # we need to check the request path
    request.path || "/"
  end

  def search_query
    params[:q]
  end

  def redirected
    (params[:redirected] || 0).to_i + 1
  end
end
