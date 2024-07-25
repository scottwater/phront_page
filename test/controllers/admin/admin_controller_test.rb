# frozen_string_literal: true

require "test_helper"

class Admin::AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_root_url
    assert_redirected_to sign_in_url
  end
end
