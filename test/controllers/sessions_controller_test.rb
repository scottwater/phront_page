require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @author = authors(:scott)
  end

  test "should get index" do
    sign_in_as @author

    get sessions_url
    assert_response :success
  end

  test "should get new" do
    get sign_in_url
    assert_response :success
  end

  test "should sign in" do
    post sign_in_url, params: {email: @author.email, password: "Secret1*3*5*"}
    assert_redirected_to admin_root_url
    with_current_blog_config do
      get root_url
    end
    assert_response :success
  end

  test "should not sign in with wrong credentials" do
    post sign_in_url, params: {email: @author.email, password: "SecretWrong1*3"}
    assert_redirected_to sign_in_url(email_hint: @author.email)
    assert_equal "That email or password is incorrect", flash[:alert]

    # We allow anonymous access to the root URL
    get sessions_url
    assert_redirected_to sign_in_url
  end

  test "should sign out" do
    sign_in_as @author

    delete session_url(@author.sessions.last)
    assert_redirected_to admin_root_url

    follow_redirect!
    assert_redirected_to sign_in_url
  end
end
