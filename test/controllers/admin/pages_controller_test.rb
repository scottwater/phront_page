# frozen_string_literal: true

require "test_helper"

class Admin::PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # post sign_in_url, params: {email: authors(:scott).email, password: "Secret1*3*5*"}
    @page = pages(:one)
  end

  test "should get index" do
    with_signed_in_author do
      get pages_url
    end
    assert_response :success
  end

  test "should get new" do
    with_signed_in_author do
      get new_page_url
    end
    assert_response :success
  end

  test "should create page" do
    assert_difference("Page.count") do
      with_signed_in_author do
        post pages_url, params: {page: {description: @page.description, image_url: @page.image_url, main_menu: @page.main_menu, markdown: @page.markdown, name: SecureRandom.hex(20), og_image_url: @page.og_image_url, template: @page.template, title: @page.title}}
      end
    end
    assert_redirected_to pages_url
  end

  test "should get edit" do
    with_signed_in_author do
      get edit_page_url(@page)
    end
    assert_response :success
  end

  test "should update page" do
    with_signed_in_author do
      patch page_url(@page), params: {page: {description: @page.description, html: @page.html, image_url: @page.image_url, main_menu: @page.main_menu, markdown: @page.markdown, name: SecureRandom.hex(5), og_image_url: @page.og_image_url, slug: @page.slug, template: @page.template, title: @page.title}}
    end
    assert_redirected_to pages_url
  end

  test "should destroy page" do
    with_signed_in_author do
      assert_difference("Page.count", -1) do
        delete page_url(@page)
      end
    end
    assert_redirected_to pages_url
  end
end
