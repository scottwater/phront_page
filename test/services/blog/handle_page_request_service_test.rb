# frozen_string_literal: true

require "test_helper"

class Blog::HandlePageRequestServiceTest < ActiveSupport::TestCase
  test "returns the home page component" do
    page = pages(:home)
    component = Blog::HandlePageRequestService.call(page: page)
    assert_equal Blog::Pages::Traditional::Component, component.class
  end

  test "the search query should be replaced in the page content" do
    page = Page.search_page
    component = Blog::HandlePageRequestService.call(page: page, search_query: "test", test: "Hey")
    assert_match "Search 'test'", component.page.title
  end

  test "If search raises an exception, display a message" do
    # Search is disabled in test environment
    def Post.search(query)
      raise ActiveRecord::StatementInvalid.new("BAD THINGS HAPPENED")
    end
    page = Page.search_page
    component = Blog::HandlePageRequestService.call(page: page, search_query: "test", test: "Hey")
    assert_match(/error processing/, component.page.html)
  end
end
