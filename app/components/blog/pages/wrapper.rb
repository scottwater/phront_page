class Blog::Pages::Wrapper < Blog::BlogViewComponent
  option :page
  option :next, default: -> { true }
  erb_template <<~TEMPLATE
    <%= c 'blog/elements/page_content', page: %>
    <%= content %>
    <%= c 'blog/pager', next: %>
  TEMPLATE
end
