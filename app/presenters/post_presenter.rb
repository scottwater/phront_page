class PostPresenter < Keynote::Presenter
  presents :post
  delegate :image_url, :html, :slug, :summary, :id, to: :post

  def published_at
    post.published_at.strftime("%B %d, %Y") if post.published_at?
  end

  def published_at_iso
    post.published_at.iso8601
  end

  def title?
    post.title?
  end

  def title # this will always return a title
    post.title.presence || post&.summary&.truncate(50)
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
