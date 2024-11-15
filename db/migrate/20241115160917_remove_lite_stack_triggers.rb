class RemoveLiteStackTriggers < ActiveRecord::Migration[8.0]
  def up
    execute "DROP TRIGGER IF EXISTS posts_search_idx_insert"
    execute "DROP TRIGGER IF EXISTS posts_search_idx_update"
    execute "DROP TRIGGER IF EXISTS posts_search_idx_update_not"
    execute "DROP TRIGGER IF EXISTS posts_search_idx_delete"
  end

  def down
    execute <<-SQL
      CREATE TRIGGER posts_search_idx_insert AFTER INSERT ON posts WHEN TRUE BEGIN
        INSERT OR REPLACE INTO posts_search_idx(rowid, title, summary, markdown)
        VALUES (NEW.rowid, NEW.title, NEW.summary, NEW.markdown);
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER posts_search_idx_update AFTER UPDATE ON posts WHEN TRUE BEGIN
        INSERT OR REPLACE INTO posts_search_idx(rowid, title, summary, markdown)
        VALUES (NEW.rowid, NEW.title, NEW.summary, NEW.markdown);
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER posts_search_idx_update_not AFTER UPDATE ON posts WHEN NOT TRUE BEGIN
        DELETE FROM posts_search_idx WHERE rowid = NEW.rowid;
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER posts_search_idx_delete AFTER DELETE ON posts BEGIN
        DELETE FROM posts_search_idx WHERE rowid = OLD.id;
      END;
    SQL
  end
end
