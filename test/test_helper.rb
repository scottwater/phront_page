ENV["RAILS_ENV"] ||= "test"
ENV["UPLOADED_ASSET_BASE_PATH"] = nil
require_relative "../config/environment"
require "minitest/autorun"
require "rails/test_help"
require "components/admin/form/test_helpers"

class ActionDispatch::IntegrationTest
  def sign_in_author(author = authors(:scott))
    post sign_in_url, params: {email: author.email, password: "Secret1*3*5*"}
    author
  end

  def with_current_blog_config(blog_config = Config::Blog.new)
    Current.stub :blog_config, blog_config do
      yield
    end
  end

  def with_signed_in_author(author = authors(:scott))
    Current.stub :session, author.sessions.create! do
      Current.stub :author, author do
        yield
      end
    end
  end
end

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in_as(author)
    post(sign_in_url, params: {email: author.email, password: "Secret1*3*5*"})
    author
  end
end

class ViewComponent::TestCase
  include Component::Form::TestHelpers

  def render_inline_with_default_author(component)
    render_inline_with_author(component, author: authors(:scott))
  end

  def render_inline_with_author(component, **)
    with_an_author(**) do
      render_inline(component)
    end
  end

  def render_inline_with_blog_config(component, **)
    with_a_blog_config(**) do
      render_inline(component)
    end
  end

  def with_a_blog_config(blog_config: nil)
    blog_config ||= Config::Blog.new
    Current.blog_config = blog_config
    yield
  end

  def with_an_author(session: nil, author: nil)
    session ||= author&.sessions&.create!
    if session
      Current.session = session
    end
    yield
  end
end
