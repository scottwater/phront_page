# frozen_string_literal: true

require "test_helper"

class Admin::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    with_signed_in_author do
      get posts_url
    end
    assert_response :success
  end

  test "should get new" do
    with_signed_in_author do
      get new_post_url
      assert_response :success
    end
  end

  test "should create post" do
    with_signed_in_author do
      assert_difference("Post.count") do
        post posts_url, params: {post: {author_id: @post.author_id, description: @post.description, html: @post.html, image_url: @post.image_url, markdown: @post.markdown, og_image_url: @post.og_image_url, page_id: @post.page_id, published_at: @post.published_at, slug: SecureRandom.hex(3), title: @post.title}}
      end
    end
    assert_redirected_to posts_url
  end

  test "should get edit" do
    with_signed_in_author do
      get edit_post_url(@post)
      assert_response :success
    end
  end

  test "should update post" do
    with_signed_in_author do
      patch post_url(@post), params: {post: {author_id: @post.author_id, description: @post.description, html: @post.html, image_url: @post.image_url, markdown: @post.markdown, og_image_url: @post.og_image_url, page_id: @post.page_id, published_at: @post.published_at, slug: @post.slug, title: @post.title}}
    end
    assert_redirected_to posts_url
  end

  test "should destroy post" do
    with_signed_in_author do
      assert_difference("Post.count", -1) do
        delete post_url(@post)
      end
    end

    assert_redirected_to posts_url
  end
end
