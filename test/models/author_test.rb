# frozen_string_literal: true

require "test_helper"

class AuthorTest < ActiveSupport::TestCase
  test "should not be first run safe if there are more than one authors" do
    authors(:scott)
    assert_not Author.first_run_safe?
  end

  test "should be first run safe with just seeded temp author" do
    Post.delete_all
    Author.delete_all
    Author.create!(email: "temp@phrontpage.com", password: SecureRandom.hex(20))
    assert Author.first_run_safe?
  end

  test "should be first run safe with no authors" do
    Post.delete_all
    Author.delete_all
    assert Author.first_run_safe?
  end
end
