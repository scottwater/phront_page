# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[7.2]
  def change
    create_table :pages do |t|
      t.string :name, null: false
      t.text :markdown, null: false
      t.text :html, null: false
      t.string :template, null: false
      t.text :slug, null: false, index: {unique: true}
      t.boolean :main_menu, default: false
      t.text :og_image_url
      t.text :image_url
      t.text :description
      t.text :title
      t.timestamps
    end
  end
end
