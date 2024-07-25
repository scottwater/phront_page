# frozen_string_literal: true

class RenameConfigConfigurationsColumn < ActiveRecord::Migration[7.2]
  def change
    rename_column :configs, :configurations, :data
    rename_column :configs, :name, :key
  end
end
