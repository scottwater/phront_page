# frozen_string_literal: true

require "application_system_test_case"
require "support/drop_helpers"
class PagesTest < ApplicationSystemTestCase
  include DropHelpers

  test "visiting the index" do
    visit pages_url
    sign_in_as(authors(:scott))
    assert_selector "a", text: "View"
  end

  test "should create page" do
    visit pages_url
    sign_in_as(authors(:scott))
    click_on "Add New Page"
    assert_current_path new_page_url
    fill_in "page_name", with: "Hello, World!"
    click_on "Create Page"
    assert_current_path pages_url
  end

  test "should set extra page details" do
    visit new_page_url
    last_page = sign_in_execute_steps_and_return_page(name: "Mo Details, Mo Problems!") do
      fill_in "page_markdown", with: "This is markdown for the test page."
      click_on "Options"
      fill_in "Description", with: "This is a description."
      fill_in "Title", with: "This is a title"
      click_on "Create Page"
    end
    assert_equal "Mo Details, Mo Problems!", last_page.name
    assert_equal "This is a title", last_page.title
    assert_equal "This is markdown for the test page.", last_page.markdown
    assert_equal "This is a description.", last_page.description
  end

  test "Drop a photo onto the editor" do
    visit new_page_url
    last_page = sign_in_execute_steps_and_return_page do
      fill_in "page_markdown", with: "This is markdown for the test page. "
      drop_file "photo.jpg", "#page_markdown"
      click_on "Create Page"
    end
    assert_current_path pages_url
    assert_match %r{<img src=".+photo.jpg.+"}, last_page.html
  end

  test "Drop a photo onto an image drop" do
    visit new_page_url
    last_page = sign_in_execute_steps_and_return_page do
      fill_in "page_markdown", with: "This is markdown for the test page."
      click_on "Options"
      drop_file("photo.jpg", "label[for=image-drop-image_url]")
      click_on "Create Page"
    end
    assert_match(/photo.jpg/, last_page.image_url)
  end

  test "You cannot change the slug on the home page" do
    page = pages(:home)
    visit edit_page_url(page)
    sign_in_as(authors(:scott))
    click_on "Options"
    refute_selector("input[name='page[slug]']")
    refute_selector("input[name='page[main_menu]']")
    refute_selector("input[name='page[exclude_posts_from_home_page]']")
  end

  test "You cannot change the slug on the search page" do
    page = pages(:search)
    visit edit_page_url(page)
    sign_in_as(authors(:scott))
    click_on "Options"
    refute_selector("input[name='page[slug]']")
    refute_selector("input[name='page[main_menu]']")
    refute_selector("input[name='page[exclude_posts_from_home_page]']")
  end

  test "You not change the slug on content pages" do
    page = pages(:one)
    visit edit_page_url(page)
    sign_in_as(authors(:scott))
    click_on "Options"
    assert_selector("input[name='page[slug]']")
    assert_selector("input[name='page[main_menu]']")
    assert_selector("input[name='page[exclude_posts_from_home_page]']")
  end

  def sign_in_execute_steps_and_return_page(name: SecureRandom.hex(10), signin: true)
    sign_in_as(authors(:scott)) if signin

    within("#page-form") do
      fill_in "page_name", with: name
      yield(name)
    end
    # Name is not ideal since it is not unique. However, since slug
    # can be changed based on page/etc it is the best we can do.
    Page.find_sole_by(name:)
  end
end
