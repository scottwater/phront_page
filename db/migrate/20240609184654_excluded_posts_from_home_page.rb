# frozen_string_literal: true

class ExcludedPostsFromHomePage < ActiveRecord::Migration[7.2]
  def change
    add_column :pages, :exclude_posts_from_home_page, :boolean, default: false
  end
end
