class RemoveLitestackVirtualTables < ActiveRecord::Migration[8.0]
  def up
    # Drop tables in reverse order due to dependencies
    tables = ["posts_search_idx_row", "posts_search_idx_instance", "posts_search_idx"]

    tables.each do |table|
      # Check if table exists before attempting to drop
      table_exists = execute(<<~SQL)
        SELECT name FROM sqlite_master
        WHERE type='table' AND name='#{table}';
      SQL

      if table_exists.any?
        execute("DROP TABLE IF EXISTS #{table};")
      end
    end
  end

  def down
    # Create posts_search_idx first
    execute <<-SQL
      CREATE VIRTUAL TABLE IF NOT EXISTS posts_search_idx USING FTS5(
        title, summary, markdown, content='', contentless_delete=1,
        tokenize='porter unicode61 remove_diacritics 2'
      );
    SQL

    # Create instance vocabulary table
    execute <<-SQL
      CREATE VIRTUAL TABLE IF NOT EXISTS posts_search_idx_instance
      USING fts5vocab(posts_search_idx, instance);
    SQL

    # Create row vocabulary table
    execute <<-SQL
      CREATE VIRTUAL TABLE IF NOT EXISTS posts_search_idx_row
      USING fts5vocab(posts_search_idx, row);
    SQL
  end
end
