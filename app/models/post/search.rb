module Post::Search
  extend ActiveSupport::Concern

  included do
    include Litesearch::Model
    litesearch do |schema|
      schema.fields %i[title summary markdown]
    end
  end
end
