require "test_helper"

class PageTest < ActiveSupport::TestCase
  test "should not include excluded posts in home page feed" do
    page = pages(:excluded_page)
    assert page.exclude_posts_from_home_page?
    post = posts(:one)
    post.page = page
    post.save!

    home_page = Page.home_page
    assert home_page.home_page?
    assert_not Post.home_page.paged.records.include?(post)
  end

  test "excluded posts should sitll be available on page feed" do
    page = pages(:excluded_page)
    assert page.exclude_posts_from_home_page?
    assert_equal 0, page.posts.count
    post = posts(:one)
    post.page = page
    post.save!
    assert_equal 1, page.posts.count
    assert_equal post, page.posts.paged.records.first
  end

  test "has HTML" do
    page = pages(:about)
    assert page.html.present?
  end

  test "The home page cannot be deleted" do
    page = pages(:home)
    assert page.home_page?
    assert_raises(RuntimeError) do
      page.destroy
    end
  end

  test "The search page cannot be deleted" do
    page = pages(:search)
    assert_raises(RuntimeError) do
      page.destroy
    end
  end

  test "There can only be one home page" do
    assert pages(:home).home_page?
    page = Page.new
    page.page_type = "home"
    page.name = "Another Home Page"
    assert_raises(ActiveRecord::RecordInvalid) do
      page.save!
    end
  end

  test "There can only be one search page" do
    assert pages(:search).search_page?
    page = Page.new
    page.page_type = "search"
    page.name = "Another Search Page"
    assert_raises(ActiveRecord::RecordInvalid) do
      page.save!
    end
  end

  test "The home page slug cannot be changed" do
    page = pages(:home)
    assert page.home_page?
    assert_equal "/", page.slug

    page.slug = "something else"
    page.save!
    assert_equal "/", page.slug
  end

  test "Pages should default to blog/pages/traditional tempalte" do
    page = Page.new
    assert_equal "blog/pages/traditional", page.template
  end
end
