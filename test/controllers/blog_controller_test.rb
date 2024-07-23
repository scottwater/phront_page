require "test_helper"

class BlogControllerTest < ActionDispatch::IntegrationTest
  test "should get a 404 for a missing page" do
    get blog_show_url("hey")
    assert_response :missing
  end

  test "should find a ppost" do
    post = posts(:one)
    get blog_show_url(slug: post.slug)
    assert_response :success
  end
end
