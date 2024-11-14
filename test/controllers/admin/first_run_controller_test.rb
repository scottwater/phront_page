# frozen_string_literal: true

require "test_helper"

class Admin::FirstRunControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    Author.stub :first_run_safe?, true do
      get first_run_url
      assert_response :success
    end
  end

  test "should not be successful if first run is not enabled" do
    # With route auth, the url no longer exists
    # so we send them back home
    Author.stub :first_run_safe?, false do
      get first_run_url
      assert_redirected_to root_url
    end
  end

  test "should create author and session" do
    Author.stub :first_run_safe?, true do
      post first_run_url, params: {email: "test@example.com", password: "password"}
      assert_redirected_to admin_root_url
      assert_match(/your account/i, flash[:notice])
    end
  end

  test "should create author, session, and set time zone" do
    Author.stub :first_run_safe?, true do
      post first_run_url, params: {email: "test@example.com", password: "password", time_zone: "America/New_York"}
      assert_redirected_to admin_root_url
      author = Author.last
      assert_equal "Eastern Time (US & Canada)", author.time_zone
      assert_match(/your account/i, flash[:notice])
    end
  end

  test "should not create author and session if email is missing" do
    Author.stub :first_run_safe?, true do
      post first_run_url, params: {password: "password"}
      assert_response :unprocessable_entity
      assert_match(/error/i, flash[:alert])
    end
  end
end
