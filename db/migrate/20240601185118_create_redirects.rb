# frozen_string_literal: true

class CreateRedirects < ActiveRecord::Migration[7.2]
  def change
    create_table :redirects do |t|
      t.text :from, null: false, index: {unique: true}
      t.text :to, null: false
      t.timestamps
    end
  end
end
