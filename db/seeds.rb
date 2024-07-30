# frozen_string_literal: true

unless Author.any?
  Author.create!(email: "temp@phrontpage.com", password: SecureRandom.hex(20))
end

home_page = Page.find_by(page_type: :home) || Page.new
home_page.update!(
  name: "Home",
  slug: "/",
  page_type: :home,
  main_menu: false
)

search_page = Page.find_by(page_type: :search) || Page.new
search_page.update!(
  name: "Search results for '{{query}}'",
  slug: "/search",
  page_type: :search,
  main_menu: false
)

about_page = Page.find_by(name: "About")
unless about_page
  about_page = Page.new
  about_page.update!(
    name: "About",
    slug: "/about",
    page_type: :content,
    main_menu: true,
    template: "blog/pages/no_posts",
    title: "About",
    markdown: "
[PhrontPage](https://phrontpage.com) is a Ruby on Rails application using [Litestack](https://github.com/oldmoe/litestack).

You can:

1. Write Posts and Pages
1. Search for posts
1. Add Redirects (helpful for migrations)
1. Add images and files to your posts and pages by simply dropping them on editor as you write
1. And much more...

Documentation will be posted on the [PhrontPage Github Repo](https://github.com/scottwater/phront_page). You can find tips, tricks, and details on what's behind the app on [Scott Watermasysk's blog](https://scottw.com).
    ".strip,
    description: "This is the about page."
  )
end

now_page = Page.find_by(name: "Now")
unless now_page
  now_page = Page.new
  now_page.update!(
    name: "Now",
    slug: "/now",
    page_type: :content,
    main_menu: true,
    template: "blog/pages/no_posts",
    title: "What I am doing now",
    markdown: "
What is [PhrontPage](https://phrontpage.com) up to?

1. Better code formatting
1. Edge caching
1. Enhanced publishing (versions, previews, etc)
1. Theming/CSS Clean up
1. Webhooks/API
1. [Your suggestions](https://github.com/scottwater/phront_page/issues)?
    ".strip,
    description: "This is the now page."
  )
end

shorts_page = Page.find_by(name: "Shorts")
unless shorts_page
  shorts_page = Page.new
  shorts_page.update!(
    name: "Shorts",
    slug: "/shorts",
    page_type: :content,
    main_menu: true,
    template: "blog/pages/shorts",
    title: "Quick Thoughts...",
    description: "Quick Thoughts..."
  )
end

phront_page_post = Post.find_by(title: nil, page_id: shorts_page.id)
unless phront_page_post
  phront_page_post = Post.new
  phront_page_post.title = nil
  phront_page_post.page_id = shorts_page.id
  phront_page_post.markdown = "
> PhrontPage is a Ruby on Rails application using Litestack.

[PhrontPage](https://phrontpage.com)
  ".strip
  phront_page_post.author = Author.first
  phront_page_post.published_at = 1.day.ago
  phront_page_post.save!
end

hello_world_post = Post.find_by(title: "Hello, World!")
unless hello_world_post
  hello_world_post = Post.new
  hello_world_post.title = "Hello, World!"
  hello_world_post.markdown = "
Welcome to PhrontPage!

You can login by navigating to [/admin](/admin). You should be prompted to create an account (unless you already have done so).

If you are using a public server, you should do this right away.

It is still early and there are limited docs. Please feel free to ask questions on the [issues](https://github.com/scottwater/phront_page/issues) page.

Happy blogging!
  ".strip
  hello_world_post.author = Author.first
  hello_world_post.published_at = 1.day.ago # Timezones are a bitch
  hello_world_post.save!
end
