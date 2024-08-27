class AddUniqueIndexOnPagesName < ActiveRecord::Migration[7.2]
  def change
    add_index :pages, :name, unique: true
  end
end
