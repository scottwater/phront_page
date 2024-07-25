# frozen_string_literal: true

class EnablePageTypesInsteadOfHomePage < ActiveRecord::Migration[7.2]
  def change
    add_column :pages, :page_type, :string, null: false, default: "content"
    remove_column :pages, :home_page, :boolean, null: false, default: false
  end
end
