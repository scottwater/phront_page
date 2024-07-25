# frozen_string_literal: true

class Config::Blog::Content < Config
  typed_store :data, coder: ActiveRecord::TypedStore::IdentityCoder do |s|
    s.integer :title_less_page_id, default: nil
  end
end
