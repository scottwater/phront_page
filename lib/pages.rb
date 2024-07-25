# frozen_string_literal: true

module Pages
  extend self

  COMPONENTS = {
    Blog::Pages::Traditional::Component => "Traditional (title, full post content) - DEFAULT",
    Blog::Pages::Cards::Component => "Cards (cards with titles snd summaries)",
    Blog::Pages::Shorts::Component => "Shorts (titleless posts)",
    Blog::Pages::TraditionalSummarized::Component => "Traditional Summarized (title, post summary)",
    Blog::Pages::NoPosts::Component => "Page Only. No Posts"
  }

  # returns an array of components. Each element is an array. The first element is the component class
  def select_list
    COMPONENTS.map { |component, description| [description, generate_component_name(component)] }
  end

  def component_list
    COMPONENTS.keys.map { |component| generate_component_name(component) }
  end

  def generate_component_name(component)
    component.name.deconstantize.underscore
  end

  def compoment_from_page(page)
    page.template.camelize.constantize::Component
  end

  def select_list_for_posts
    Page.where(page_type: :content).pluck(:name, :id)
  end

  def select_list_for_posts_with_no_page
    select_list_for_posts.insert(0, ["No Page", nil])
  end
end
