require "test_helper"

class Blog::FetchBlogContentFromRequestServiceTest < ActiveSupport::TestCase
  test "returns a page before a post" do
    slug = "/test"
    page = Page.create!(slug:, name: "Test")
    Post.create!(author: authors(:scott), slug:, title: "Test", markdown: "HELLO WORLD", published_at: Time.current)

    result = Blog::FetchBlogContentFromRequestService.call(slug: slug)
    assert_equal page, result
  end

  test "returns a post before a redirect" do
    slug = "/test"

    post = Post.create!(author: authors(:scott), slug:, title: "Test", markdown: "HELLO WORLD", published_at: Time.current)
    Redirect.create!(from: slug, to: "/test2")
    result = Blog::FetchBlogContentFromRequestService.call(slug: slug)
    assert_equal post, result
  end

  test "returns a redirect if it is the only thing found" do
    slug = "/test"
    redirect = Redirect.create!(from: slug, to: "/test2")
    result = Blog::FetchBlogContentFromRequestService.call(slug: slug)
    assert_equal redirect, result
  end

  test "returns nothing if there are no pages, posts, or redirects found" do
    assert_nil Blog::FetchBlogContentFromRequestService.call(slug: "/test")
  end
end
