# frozen_string_literal: true

class RemoveAuthorNetworks < ActiveRecord::Migration[7.2]
  def change
    remove_column :authors, :x, :string
    remove_column :authors, :mastodon, :string
    remove_column :authors, :linkedin, :string
    remove_column :authors, :instagram, :string
    remove_column :authors, :github, :string
  end
end
