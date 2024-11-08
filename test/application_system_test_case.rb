# frozen_string_literal: true

require "test_helper"

Capybara.register_driver :searls do |app|
  Capybara::Playwright::Driver.new(app,
    browser_type: ENV["PLAYWRIGHT_BROWSER"]&.to_sym || :chromium,
    headless: (false unless ENV["CI"] || ENV["PLAYWRIGHT_HEADLESS"]))
end

Capybara.server = :puma, {Silent: true} # To clean up your test output

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :searls

  def wait_until(time: Capybara.default_max_wait_time)
    Timeout.timeout(time) do
      until (value = yield)
        sleep(0.1)
      end
      value
    end
  end

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
