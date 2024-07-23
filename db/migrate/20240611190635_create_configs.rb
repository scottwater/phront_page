class CreateConfigs < ActiveRecord::Migration[7.2]
  def change
    create_table :configs do |t|
      t.string :name, null: false, index: {unique: true}
      t.json :configurations, default: {}, null: false
      t.timestamps
    end
  end
end
