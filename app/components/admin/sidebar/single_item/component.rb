# frozen_string_literal: true

class Admin::Sidebar::SingleItem::Component < Admin::AdminViewComponent
  option :icon, default: proc { :bug }
  option :text
  option :url
end
