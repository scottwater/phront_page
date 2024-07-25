# frozen_string_literal: true

class Admin::ProfilePresenter < ::ProfilePresenter
  def name
    "#{author.first_name} #{author.last_name}".presence || author.email
  end
end
