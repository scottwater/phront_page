class ApplicationViewComponentPreview < ViewComponentContrib::Preview::Base
  class SkippedPreviewComponent < ApplicationViewComponent
    option :text, default: -> { "Please see comments for why this was skipped" }

    erb_template <<~TEMPLATE
      <div class="bg-red-50 p-4 text-red-500">
        <h1 class="font-bold text-4xl">Preview Skipped</h1>
        <p><%= text %></p>
      </div>
    TEMPLATE
  end
  self.abstract_class = true
  layout "blank"

  def with_current_blog_config(blog_config = Config::Blog.new)
    Current.blog_config = blog_config
    yield
  end

  def with_current_author(author)
    Current.session = author.sessions.create!
    yield
  end

  def form_with(object, options = {})
    object_name = options[:as] || object.class.name.underscore
    ActionView::Helpers::FormBuilder.new(object_name, object, template, options)
  end

  def template
    lookup_context = ActionView::LookupContext.new(ActionController::Base.view_paths)
    ActionView::Base.new(lookup_context, {}, ApplicationController.new)
  end

  def skip_preview(text = "please see comments for why this was skipped")
    render(SkippedPreviewComponent.new(text:))
  end

  def default_page
    html = Content::Markdown.to_html(Faker::Markdown.sandwich(sentences: 15))
    Page.new(title: "Page Title", html: html, slug: "/page-slug")
  end
end
