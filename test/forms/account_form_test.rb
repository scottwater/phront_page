# frozen_string_literal: true

require "test_helper"

class AccountFormTest < ActiveSupport::TestCase
  test "should save the author and change the password" do
    author = authors(:scott)
    form = AccountForm.new(author: author, params: {password: "Secret1*3*5*", new_password: "NewPassword", confirm_new_password: "NewPassword"})
    assert form.save
    author.reload
    assert author.authenticate("NewPassword")
  end

  test "should not save the author if the existing password is wrong" do
    author = authors(:scott)
    form = AccountForm.new(author: author, params: {password: "WRONG", new_password: "NewPassword", confirm_new_password: "NewPassword"})
    refute form.save
  end

  test "should not save author if the passwords do not match" do
    author = authors(:scott)
    form = AccountForm.new(author: author, params: {password: "Secret1*3*5*", new_password: "PasswordNew", confirm_new_password: "NewPassword"})
    refute form.save
    assert_match(/does not match/, author.errors.full_messages.first)
  end
end
