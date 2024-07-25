# frozen_string_literal: true

require "test_helper"

class ConfigTest < ActiveSupport::TestCase
  test "should always find or create a config" do
    Config.delete_all
    blog_config = Config::Blog.new
    assert blog_config.socials.new_record?
    assert blog_config.meta.new_record?
    assert blog_config.settings.new_record?
  end

  test "should persist a config" do
    socials = Config::Blog.new.socials
    socials.x_url = "https://x.com/scottw"
    socials.x_username = "@scottw"
    socials.save!

    socials = Config::Blog.new.socials
    assert_equal "https://x.com/scottw", socials.x_url
    assert_equal "@scottw", socials.x_username
  end

  test "should not allow a duplicat key" do
    socials = Config::Blog.new.socials
    socials.x_url = "https://x.com/scottw"
    socials.x_username = "@scottw"
    socials.save!

    assert_raises ActiveRecord::RecordInvalid do
      duplicate_socails = Config::Blog::Socials.new
      duplicate_socails.x_url = "https://x.com/scottw2"
      duplicate_socails.x_username = "@scottw2"
      duplicate_socails.save!
    end
  end
end
