class FtsPost < ApplicationRecord
  self.table_name = "fts_posts"

  # Since virtual tables don't have primary keys by default
  self.primary_key = nil

  # Disable timestamps since FTS tables don't support them
  self.record_timestamps = false

  belongs_to :post
end
