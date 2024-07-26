# frozen_string_literal: true

require "test_helper"

class FeedControllerTest < ActionDispatch::IntegrationTest
  test "should return a json feed by by default" do
    get feed_url
    assert_response :success
    assert_equal "application/json; charset=utf-8", response.content_type
    data = JSON.parse(response.body)
    post = posts(:one)
    assert_equal post.title, data.dig("items", 0, "title")
  end

  test "should return an atom feed" do
    get feed_url(format: :atom)
    assert_response :success
  end

  test "should return an rss feed" do
    get feed_url(format: :rss)
    assert_response :success
  end

  test "should return an xml feed" do
    get feed_url(format: :xml)
    assert_response :success
    assert_equal "application/xml; charset=utf-8", response.content_type
    assert_match(/<title>My PhrontPage Blog<\/title>/, response.body)
  end

  test "should return a 304 status if the feed is stale" do
    last_modified = Post.root_feed.maximum(:updated_at)
    get feed_url, headers: {"If-Modified-Since" => last_modified.httpdate}
    assert_response :not_modified
  end

  # test "should return a 304 if the etag is the same" do
  #   posts = Post.root_feed
  #   last_modified = posts.maximum(:updated_at)
  #   get feed_url
  #   etag = response.headers["ETag"]
  #   get feed_url, headers: {"If-Modified-Since" => last_modified.httpdate, "If-None-Match" => etag}
  #   assert_response :not_modified
  # end

  test "A post in the future should break the cache" do
    # Existing posts are in the past
    get feed_url
    last_modified = response.headers["Last-Modified"]
    get feed_url, headers: {"If-Modified-Since" => last_modified}
    assert_response :not_modified
    # Create a post in the future
    post = Post.new
    post.title = "My Future Post"
    post.markdown = "This is a future post"
    post.author = authors(:scott)
    post.published_at = Time.current
    post.updated_at = Post.root_feed.maximum(:updated_at) - 1.hour
    post.save!
    get feed_url, headers: {"If-Modified-Since" => last_modified}
    assert_response :success
  end
end
