class Config::Blog::Meta < Config
  typed_store :data, coder: ActiveRecord::TypedStore::IdentityCoder do |s|
    s.string :name, default: "PhrontPage"
    s.string :title, default: "My PhrontPage Blog"
    s.string :subtitle, default: "Blawging with Rails"
    s.string :og_image_url, default: nil
    s.string :logo, default: nil, blank: false
    s.string :copyright, default: "All rights reserved"
  end

  validates :name, presence: true
  validates :title, presence: true
  validates :copyright, presence: true
end
