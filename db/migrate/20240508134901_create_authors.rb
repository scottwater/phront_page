class CreateAuthors < ActiveRecord::Migration[7.2]
  def change
    create_table :authors do |t|
      t.string :email, null: false, index: {unique: true}
      t.string :password_digest, null: false
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.text :avatar_url
      t.string :github
      t.string :x
      t.string :mastodon
      t.string :linkedin
      t.string :instagram
      t.timestamps
    end
  end
end
