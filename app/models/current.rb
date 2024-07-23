class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :user_agent, :ip_address
  attribute :blog_config
  attribute :post
  attribute :page

  delegate :author, to: :session, allow_nil: true
end
