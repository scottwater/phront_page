# frozen_string_literal: true

class Author < ApplicationRecord
  has_secure_password

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end
  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  has_many :sessions, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, allow_nil: true, length: {minimum: 6}

  normalizes :email, with: -> { _1.strip.downcase }

  def self.first_run_safe?
    count == 0 || (count == 1 && Author.first.email == "temp@phrontpage.com")
  end

  def time_zone
    self[:time_zone] || "UTC"
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end
end
