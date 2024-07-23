# frozen_string_literal: true

class Blog::Pages::NoPosts::Component < Blog::Pages::Base
  # This componet does not render anything. It is used for traditional pages that have no posts
  erb_template <<~TEMPLATE
    <%= render Blog::Pages::Wrapper.new(page:, next: false) %>
  TEMPLATE
end
