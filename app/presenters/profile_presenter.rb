# frozen_string_literal: true

class ProfilePresenter < Keynote::Presenter
  presents :author
  delegate :email, :bio, :id, to: :author

  def avatar_url
    author.avatar_url.presence || "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(author.email)}?s=200"
  end

  def name
    "#{author.first_name} #{author.last_name}".presence || author.email.split("@").first
  end
end
