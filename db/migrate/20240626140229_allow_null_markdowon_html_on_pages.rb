# frozen_string_literal: true

class AllowNullMarkdowonHtmlOnPages < ActiveRecord::Migration[7.2]
  def change
    change_column :pages, :markdown, :text, null: true
    change_column :pages, :html, :text, null: true
  end
end
