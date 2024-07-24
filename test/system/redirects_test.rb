require "application_system_test_case"

class RedirectsTest < ApplicationSystemTestCase
  setup do
    @redirect = redirects(:one)
  end

  test "visiting the index" do
    visit redirects_url
    sign_in_as(authors(:scott))
    assert_selector "th", text: "FROM"
  end

  test "should create redirect" do
    visit redirects_url
    sign_in_as(authors(:scott), remember_me: true)
    assert_current_path redirects_url

    click_on "Add New Redirect"
    assert_current_path new_redirect_url

    fill_in "From", with: SecureRandom.hex(4)
    fill_in "To", with: SecureRandom.hex(4)
    click_on "Create Redirect"

    assert_text "Redirect was successfully created"
  end

  test "should update Redirect" do
    visit redirects_url
    sign_in_as(authors(:scott), remember_me: true)
    click_on "Edit", match: :first

    fill_in "From", with: @redirect.from
    fill_in "To", with: @redirect.to
    click_on "Update Redirect"

    assert_text "Redirect was successfully updated"
  end

  test "should destroy Redirect" do
    visit redirects_url
    sign_in_as(authors(:scott), remember_me: true)
    first_td_content_before = find("table tbody tr:first-child td:first-child").text
    accept_confirm do
      click_on "Delete", match: :first
    end
    assert_current_path redirects_url
    assert_text "Redirect was successfully destroyed"
    assert_no_text first_td_content_before
  end
end
