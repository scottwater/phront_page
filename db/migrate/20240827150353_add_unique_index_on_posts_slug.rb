class AddUniqueIndexOnPostsSlug < ActiveRecord::Migration[7.2]
  def change
    add_index :posts, :slug, unique: true
  end
end
