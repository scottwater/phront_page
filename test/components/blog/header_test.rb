# frozen_string_literal: true

require "test_helper"

# To Do: Need a way to remove the hard coded primary color

class Blog::Header::ComponentTest < ViewComponent::TestCase
  def test_sets_active_class
    post = posts(:one)
    post.page = pages(:about)
    post.save!
    vc_test_request.stub(:path, post.slug) do
      component = build_component
      render_inline_with_blog_config(component)
    end
    assert_selector "li a.text-primary-700", text: pages(:about).name
  end

  def test_ensure_we_do_not_always_set_home_as_active
    vc_test_request.stub(:path, "/something-weird") do
      component = build_component
      render_inline_with_blog_config(component)
    end
    refute_selector "li a.text-primary-700", text: pages(:home).name
  end

  private

  def build_component(**)
    Blog::Header::Component.new(**)
  end
end
