class Config::Blog::Settings < Config
  typed_store :data, coder: ActiveRecord::TypedStore::IdentityCoder do |s|
    s.string :base_url, null: false
    s.string :header, null: true, blank: false
    s.string :footer, null: true, blank: false
  end

  validates :base_url, presence: true

  before_save do
    self.base_url = base_url&.strip&.chomp("/")
  end
end
