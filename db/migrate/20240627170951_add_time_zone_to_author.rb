class AddTimeZoneToAuthor < ActiveRecord::Migration[7.2]
  def change
    add_column :authors, :time_zone, :string
  end
end
