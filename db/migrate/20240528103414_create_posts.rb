class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.text :markdown, null: false
      t.text :html, null: false
      t.text :slug, null: false
      t.text :og_image_url
      t.text :image_url
      t.text :description
      t.text :title
      t.references :author, null: false, foreign_key: true
      t.references :page, null: true, foreign_key: true
      t.datetime :published_at
      t.timestamps
    end
  end
end
