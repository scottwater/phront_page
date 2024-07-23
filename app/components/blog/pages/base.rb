class Blog::Pages::Base < Blog::BlogViewComponent
  option :page
  option :posts, default: -> { [] }
  option :next, default: -> { true }
end
