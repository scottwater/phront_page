class CreatePostsSearchTable < ActiveRecord::Migration[8.0]
  def up
    execute("CREATE VIRTUAL TABLE fts_posts USING fts5(title, markdown, description, post_id)")
  end

  def down
    execute("DROP TABLE IF EXISTS fts_posts")
  end
end
