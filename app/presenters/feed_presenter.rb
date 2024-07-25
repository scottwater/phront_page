# frozen_string_literal: true

class FeedPresenter < Keynote::Presenter
  presents :post
  delegate :image_url, :html, :slug, :summary, :id, to: :post

  def published_at
    post.published_at.iso8601
  end

  def title?
    post.title?
  end

  def title # this will always return a title
    post.title.presence || post&.summary&.truncate(50)
  end

  def url
    "#{Current.blog_config.settings.base_url}#{post.slug}"
  end

  def author
    k(:profile, post.author)
  end

  def author_name
    k(:profile, post.author).name
  end

  def to_model
    post.to_model
  end
end
