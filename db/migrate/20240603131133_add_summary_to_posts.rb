class AddSummaryToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :summary, :text
  end
end
