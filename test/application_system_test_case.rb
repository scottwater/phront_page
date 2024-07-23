require "test_helper"

Capybara.register_driver :searls do |app|
  Capybara::Playwright::Driver.new(app,
    browser_type: ENV["PLAYWRIGHT_BROWSER"]&.to_sym || :chromium,
    headless: (false unless ENV["CI"] || ENV["PLAYWRIGHT_HEADLESS"]))
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :searls

  def sign_in_as(user, remember_me: false)
    assert_current_path sign_in_url
    fill_in :email, with: user.email
    fill_in :password, with: "Secret1*3*5*"
    if remember_me
      check :remember_me
    end
    click_on "Sign In"
    user
  end
end
