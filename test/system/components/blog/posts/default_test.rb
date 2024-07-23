# frozen_string_literal: true

require "application_system_test_case"

class Blog::Posts::Default::ComponentSystemTest < ApplicationSystemTestCase
  def test_default_preview
    post = posts(:one)
    visit("/rails/view_components/blog/posts/default/with_post?post_id=#{post.id}")

    assert_text post.title
    assert_text post.markdown
    # click_on("Click me!")
    # assert_text "Good-bye!"
  end
end
