# frozen_string_literal: true

require "test_helper"

class ActiveStorage::Service::S3WithPrefixServiceTest < ActiveSupport::TestCase
  test "should return the correct path" do
    service = ActiveStorage::Service::S3WithPrefixService.new(bucket: "bucket", region: "region")
    ENV["UPLOAD_PREFIX"] = "/prefix"
    assert_equal "prefix/key", service.path_for("key")
    ENV["UPLOAD_PREFIX"] = "prefix"
    assert_equal "prefix/key", service.path_for("key")
    ENV["UPLOAD_PREFIX"] = "/prefix/"
    assert_equal "prefix/key", service.path_for("key")
    ENV["UPLOAD_PREFIX"] = "/"
    assert_equal "key", service.path_for("key")
    ENV["UPLOAD_PREFIX"] = nil
    assert_equal "key", service.path_for("key")
  end
end
