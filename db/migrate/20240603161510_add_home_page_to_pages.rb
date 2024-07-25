# frozen_string_literal: true

class AddHomePageToPages < ActiveRecord::Migration[7.2]
  def change
    add_column :pages, :home_page, :boolean
  end
end
