# frozen_string_literal: true

class AccountForm
  extend Dry::Initializer

  option :author
  option :params

  def save
    if valid_exisiting_password?
      validate_and_set_new_password
      if author.errors.empty?
        author.email = email.strip if email.present?
      end
      if author.errors.empty?
        author.save
      else
        false
      end
    end
  end

  private

  def valid_exisiting_password?
    author.authenticate(current_password).tap do |valid|
      unless valid
        author.errors.add(:password, "could not be verified")
      end
    end
  end

  def current_password
    params[:password]
  end

  def new_password
    params[:new_password]
  end

  def confirm_new_password
    params[:confirm_new_password]
  end

  def email
    params[:email]
  end

  def validate_and_set_new_password
    if new_password.present? && confirm_new_password.present?
      if new_password == confirm_new_password
        author.password = new_password
      else
        author.errors.add(:new_password, "does not match confirmation")
      end
    end
  end
end
