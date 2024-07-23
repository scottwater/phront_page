require "test_helper"

class PostTest < ActiveSupport::TestCase
  class SlugTest < PostTest
    test "slug is always downcased" do
      post = Post.new(title: "Hello, World!", slug: "HELLO WORLD")
      post.save
      assert_equal "/hello-world", post.slug
    end

    test "when a slug is changed, it should generate a new redirect" do
      assert_difference("Redirect.count") do
        post = posts(:one)
        post.slug = "this changes everything"
        post.save!
      end
    end

    test "slug should include the page slug if the post is a child of a page" do
      page = Page.create!(name: "Hello, World!", markdown: "Hello, World!")
      post = Post.create!(title: "A Post", markdown: "WAT", page: page, author: authors(:scott))
      assert_equal "/hello-world/a-post", post.slug
    end

    test "a slug can be changed and still include it's title" do
      page = Page.create!(name: "Hello, World!", markdown: "Hello, World!")
      post = Post.create!(title: "A Post", markdown: "WAT", page: page, author: authors(:scott))
      assert_equal "/hello-world/a-post", post.slug
      post.slug = "Something Else"
      post.save!
      assert_equal "/hello-world/something-else", post.slug
    end

    test "a post's page can change and will be shown in the slug" do
      page = Page.create!(name: "Hello, World!", markdown: "Hello, World!")
      post = Post.create!(title: "A Post", markdown: "WAT", page: page, author: authors(:scott))
      assert_equal "/hello-world/a-post", post.slug
      new_page = Page.create!(name: "Another Page", markdown: "Hello, World!")
      post.page = new_page
      post.save!
      assert_equal "/another-page/a-post", post.slug
    end
  end

  class PublishedTest < PostTest
    test "unpublished posts are not published" do
      post = posts(:unpublished)
      assert_not post.published?
    end

    test "published posts are published" do
      post = posts(:one)
      assert post.published?
    end

    test "published_at is in the future will not be published" do
      post = posts(:one)
      post.published_at = 2.days.from_now
      assert_not post.published?
    end

    test "only return published posts" do
      assert_equal 2, Post.published.count
    end

    test "should use a the default page with no title when configured" do
      page = Page.create!(name: "Shorts")
      config = Config::Blog.new
      config.content.title_less_page_id = page.id
      config.content.save!
      post = Post.create!(author: authors(:scott), markdown: "Testing")
      assert_equal page, post.page
    end

    test "should not use a the default page a title" do
      page = Page.create!(name: "Shorts")
      config = Config::Blog.new
      config.content.title_less_page_id = page.id
      config.content.save!
      post = Post.create!(author: authors(:scott), markdown: "Testing", title: "Hello, World!")
      assert_nil post.page
    end
  end

  class SummaryTest < PostTest
    test "summary is is based on supplied content with <!--more--> tag" do
      post = Post.new(markdown: "Hello, World!<!--more-->This is the rest of the content")
      post.generate_summary
      assert_equal "Hello, World!", post.summary
    end

    test "summary is not generated if it already exists" do
      post = Post.new(markdown: "Hello, World! This is the rest of the content", summary: "HERE!")
      post.generate_summary
      assert_equal "HERE!", post.summary
    end

    test "delimited summary is used even with a summary is included" do
      post = Post.new(markdown: "Hello, World!<!--more-->This is the rest of the content", summary: "HERE!")
      post.generate_summary
      assert_equal "Hello, World!", post.summary
    end
  end
end
