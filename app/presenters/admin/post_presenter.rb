# frozen_string_literal: true

class Admin::PostPresenter < Keynote::Presenter
  presents :post
  delegate :slug, :summary, :id, to: :post

  def published_at
    post.published_at.strftime("%B %d, %Y") if post.published_at?
  end

  def published_at_with_time
    post.published_at.strftime("%B %d, %Y at %I:%M %p") if post.published_at?
  end

  def published?
    post.published_at? && post.published_at <= Time.current
  end

  def title?
    post.title?
  end

  def title
    (post.title.presence || post.summary)&.truncate(50)
  end

  def html
    post.html&.html_safe
  end

  def to_model
    post.to_model
  end
end
