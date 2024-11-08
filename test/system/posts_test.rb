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
      send_keys(:escape) # Need to use escape to close the drawer
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
    last_post = sign_in_execute_steps_and_return_post do
      fill_in "post_markdown", with: "This is a test post."
      click_on "Options"
      # Add wait for drawer to be visible
      assert_selector "label[for=image-drop-og_image_url]"
      drop_file("photo.jpg", "label[for=image-drop-og_image_url]")
      # Wait for upload to complete
      assert_selector "div[data-admin--form--image-drop--component-target='previewZone'] img"
      send_keys(:escape)
      click_on "Create Post"
      # Wait for form submission
      assert_no_selector "#post-form"
    end
    assert_match(/photo.jpg/, last_post.og_image_url)
  end

  test "update a post" do
    post = Post.create!(
      author: authors(:scott),
      title: "Test Post",
      markdown: "This is a test post.",
      page: pages(:about),
      image_url: "https://picsum.photos/id/237/600/800"
    )
    newly_selected_page = Pages.select_list_for_posts.find { |page| page[1] != post.page_id }
    assert_not_nil post.image_url
    visit edit_post_url(post)

    sign_in_as(authors(:scott))
    within("#post-form") do
      fill_in "post_title", with: "Updated Title"
      fill_in "post_markdown", with: "Updated Markdown"
      click_on "Options"
      # Add wait for drawer
      assert_selector "textarea[name='post[summary]']"
      fill_in "Summary", with: "Updated Summary"
      fill_in "Description", with: "Updated Description"
      select newly_selected_page[0], from: "Page"
      find("div[data-admin--form--image-drop--component-target='previewZone'] a").click
      # Wait for preview to update
      assert_selector "label[for=image-drop-og_image_url]"
      drop_file("photo.jpg", "label[for=image-drop-og_image_url]")
      # Wait for upload
      assert_selector "div[data-admin--form--image-drop--component-target='previewZone'] img"
      send_keys(:escape)
      click_button "Update Post"
      # Wait for form submission
      assert_no_selector "#post-form"
    end

    # Use find_by! instead of reload to ensure we get a fresh record
    updated_post = Post.find(post.id)
    assert_equal "Updated Title", updated_post.title
    assert_equal "Updated Markdown", updated_post.markdown
    assert_equal "Updated Summary", updated_post.summary
    assert_equal "Updated Description", updated_post.description
    assert_equal newly_selected_page[1], updated_post.page_id
    assert_match(/photo.jpg/, updated_post.og_image_url)
    assert_nil updated_post.image_url
  end

  def sign_in_execute_steps_and_return_post(title: SecureRandom.hex(10), signin: true)
    sign_in_as(authors(:scott)) if signin
    within("#post-form") do
      fill_in "post_title", with: title
      yield(title)
    end
    assert_no_selector "#post-form"
    wait_until do
      Post.find_by!(title: title)
    end
  end
end
