class CreateRevisions < ActiveRecord::Migration[7.2]
  def change
    create_table :revisions do |t|
      t.json :data, null: false, default: {}
      t.references :record, polymorphic: true, null: true
      t.string :uid, null: true
      t.json :attributes_with_changes, null: false, default: {}
      t.string :revision_type, null: false
      t.timestamps
    end
  end
end
