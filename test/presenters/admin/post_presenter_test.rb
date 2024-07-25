# frozen_string_literal: true

require "test_helper"

class Admin::PostPresenterTest < Keynote::TestCase
  test "generate a title from the summary" do
    post = Post.new(summary: "A summary")
    presenter = present("admin/post", post)
    assert_equal "A summary", presenter.title
  end
end
