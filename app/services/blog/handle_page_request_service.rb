class Blog::HandlePageRequestService < ApplicationService
  option :page
  option :paging_id, optional: true, default: proc { 1 }
  option :search_query, optional: true

  def call
    case page.page_type
    in "home"
      component_with_query(paged(posts.home_page))
    in "search"
      begin
        gsub_search_query!
        component_with_query(paged(posts(ordered: false).search(search_query)))
      rescue ActiveRecord::StatementInvalid => ex
        set_paging_error_message(ex)
        component_with_query(ApplicationRecord::PagedData.new([], 0))
      end
    else
      component_with_query(paged(posts.where(page_id: page.id)))
    end
  end

  private

  def posts(ordered: true)
    query = Post.published
    ordered ? query.ordered : query
  end

  def component_with_query(pager)
    component = Pages.compoment_from_page(page)
    component.new(page: page, posts: pager.records, next: pager.next?)
  end

  def set_paging_error_message(paging_exception)
    page.html = if Rails.env.development?
      "<p>#{paging_exception.message}</p>"
    else
      "<p>There was an error processing your search. Please try again later.</p>"
    end
  end

  def gsub_search_query!
    page&.name&.gsub!("{{query}}", search_query)
    page&.html&.gsub!("{{query}}", search_query)
    page&.title&.gsub!("{{query}}", search_query)
  end

  # needs to be called last.
  def paged(query)
    query.paged(paging_id:)
  end
end
