# frozen_string_literal: true

class Blog::Elements::Html::Component < Blog::BlogViewComponent
  option :html, optional: true

  def render?
    !!(content || html)
  end

  erb_template <<~TEMPLATE
    <div>
      <%== content&.html_safe || html&.html_safe %>
    </div>
  TEMPLATE
end
