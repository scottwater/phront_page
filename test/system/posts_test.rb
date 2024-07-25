# frozen_string_literal: true

require "application_system_test_case"
require "support/drop_helpers"
class PostsTest < ApplicationSystemTestCase
  include DropHelpers
  test "visiting the index" do
    visit posts_url
    sign_in_as(authors(:scott))
    assert_selector "a", text: "View"
  end

  test "should create post" do
    visit posts_url
    sign_in_as(authors(:scott))
    click_on "Add New Post"
    title = "Hello, World! #{SecureRandom.hex(5)}"
    last_post = sign_in_execute_steps_and_return_post(title:, signin: false) do
      assert_current_path new_post_url
      fill_in "post_markdown", with: "This is a test post."
      click_on "Create Post"
      assert_current_path posts_url
    end
    assert_equal title, last_post.title
  end

  test "should set extra post details" do
    visit new_post_url
    last_post = sign_in_execute_steps_and_return_post do
      fill_in "post_markdown", with: "This is a test post."
      click_on "Options"
      fill_in "Summary", with: "This is a summary."
      select Pages.select_list_for_posts.first[0], from: "Page"
      fill_in "Description", with: "This is a description."
      fill_in "Published at", with: "2021-01-01 12:00:00"
      click_on "Create Post"
      assert_current_path posts_url
    end
    assert_equal "This is a test post.", last_post.markdown
    assert_equal "This is a summary.", last_post.summary
    assert_equal Pages.select_list_for_posts.first[1], last_post.page_id
    assert_equal "This is a description.", last_post.description
    assert_equal Time.zone.parse("2021-01-01 12:00:00"), last_post.published_at
  end

  test "Drop a photo onto the editor" do
    visit new_post_url
    last_post = sign_in_execute_steps_and_return_post do
      fill_in "post_markdown", with: "This is a test post. "
      drop_file "photo.jpg", "#post_markdown"
      click_on "Create Post"
    end
    assert_match %r{<img src=".+photo.jpg.+"}, last_post.html
  end

  test "Drop a photo onto an image drop" do
    visit new_post_url
    last_post = sign_in_execute_steps_and_return_post do |title|
      fill_in "post_markdown", with: "This is a test post."
      click_on "Options"
      drop_file("photo.jpg", "label[for=image-drop-og_image_url]")
      click_on "Create Post"
    end
    assert_match(/photo.jpg/, last_post.og_image_url)
  end

  test "update a post" do
    post = posts(:one)
    # First page that is not the current page
    newly_selected_page = Pages.select_list_for_posts.find { |page| page[1] != post.page_id }
    assert_not_nil post.image_url
    visit edit_post_url(post)

    sign_in_as(authors(:scott))
    within("#post-form") do
      fill_in "post_title", with: "Updated Title"
      fill_in "post_markdown", with: "Updated Markdown"
      click_on "Options"
      fill_in "Summary", with: "Updated Summary"
      fill_in "Description", with: "Updated Description"
      select newly_selected_page[0], from: "Page"
      find("div[data-admin--form--image-drop--component-target='previewZone'] a").click
      drop_file("photo.jpg", "label[for=image-drop-og_image_url]")
      click_button "Update Post"
    end

    post.reload
    assert_equal "Updated Title", post.title
    assert_equal "Updated Markdown", post.markdown
    assert_equal "Updated Summary", post.summary
    assert_equal "Updated Description", post.description
    assert_equal newly_selected_page[1], post.page_id
    assert_match(/photo.jpg/, post.og_image_url)
    assert_nil post.image_url
  end

  def sign_in_execute_steps_and_return_post(title: SecureRandom.hex(10), signin: true)
    sign_in_as(authors(:scott)) if signin
    within("#post-form") do
      fill_in "post_title", with: title
      yield(title)
    end
    # Title is not ideal since it is not unique. However, since slug
    # can be changed based on page/etc it is the best we can do.
    Post.find_sole_by(title:)
  end
end
