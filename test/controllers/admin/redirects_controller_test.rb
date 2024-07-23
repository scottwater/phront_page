require "test_helper"

class Admin::RedirectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @redirect = redirects(:one)
  end

  test "should get index" do
    with_signed_in_author do
      get redirects_url
    end
    assert_response :success
  end

  test "should get new" do
    with_signed_in_author do
      get new_redirect_url
    end
    assert_response :success
  end

  test "should create redirect" do
    with_signed_in_author do
      assert_difference("Redirect.count") do
        post redirects_url, params: {redirect: {from: SecureRandom.hex(4), to: SecureRandom.hex(4)}}
      end
    end
    assert_redirected_to redirects_url
  end

  test "should get edit" do
    with_signed_in_author do
      get edit_redirect_url(@redirect)
    end
    assert_response :success
  end

  test "should update redirect" do
    with_signed_in_author do
      patch redirect_url(@redirect), params: {redirect: {from: @redirect.from, to: @redirect.to}}
    end
    assert_redirected_to redirects_path
  end

  test "should destroy redirect" do
    with_signed_in_author do
      assert_difference("Redirect.count", -1) do
        delete redirect_url(@redirect)
      end
    end
    assert_redirected_to redirects_url
  end
end
