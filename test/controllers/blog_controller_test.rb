# frozen_string_literal: true

require "test_helper"

class BlogControllerTest < ActionDispatch::IntegrationTest
  test "should get a 404 for a missing page" do
    get blog_show_url("hey")
    assert_response :missing
  end

  test "should redirect to the base url if force_base_url is true" do
    blog_config = Config::Blog.new
    blog_config.settings.force_base_url = true
    blog_config.settings.base_url = "https://scottw.com"
    with_current_blog_config(blog_config) do
      get blog_show_url("hey")
      assert_redirected_to "https://scottw.com/hey"
    end
  end

  test "should NOT redirect to the base url if force_base_url is not set" do
    blog_config = Config::Blog.new
    blog_config.settings.base_url = "https://scottw.com"
    with_current_blog_config(blog_config) do
      get blog_show_url("/")
      assert_response :success
    end
  end

  test "should NOT redirect to the base url is not set" do
    blog_config = Config::Blog.new
    blog_config.settings.base_url = nil
    blog_config.settings.force_base_url = true
    with_current_blog_config(blog_config) do
      get blog_show_url("/")
      assert_response :success
    end
  end

  test "should find a ppost" do
    post = posts(:one)
    get blog_show_url(slug: post.slug)
    assert_response :success
  end
end
