# frozen_string_literal: true

class Blog::Header::Component < Blog::BlogViewComponent
  class Link < Blog::BlogViewComponent
    option :page

    def style
      super(active:)
    end

    def active
      (page.slug == request.path) ||
        (request.path.starts_with?(page.slug) && !page.home_page?) ||
        (page.home_page? && request.path == "/")
    end

    style do
      base {
        %w[block py-2 pr-4 pl-3 border-b border-gray-100 hover:bg-gray-50 lg:hover:bg-white lg:border-0 lg:hover:text-primary-700 lg:p-0 dark:text-gray-400 lg:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent dark:border-gray-700]
      }
      variants {
        active {
          yes { %w[text-primary-700] }
          no { %w[text-gray-700] }
        }
      }
    end

    def call
      link_to page.name, page.slug, class: style
    end
  end

  def apply_active_classes(page)
    if page.slug == request.path
      "text-primary-700"
    else
      ""
    end
  end
end
