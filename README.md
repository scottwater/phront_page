# PhrontPage

**Warning**: _This is a work in progress. It is at the stage that it hits many of my personal goals. Still, I expect it to continue to evolve, especially if others are interested in using and contributing to it._

## Why PhrontPage?

I have opinions too many opinions about blogging.

## Why not use WordPress?

WordPress is perfectly suitable for most. I recommend you use it. I wanted my content to live in something I understood and felt comfortable modifying from top to bottom. If this sounds like you and you enjoy Rails, I think you will like the experience.

## Why not a static site generator?

The slight friction of using a static site generator can be good, but it was in the way for me. I have a few features in mind that get us close to most of a static site generator the speed without the friction.

## Current Main Feature Set
- Pages
- Posts
- Posts can be published on pages
- Built-in search (Litestack!)
- Built-in redirects (you can define them, automatically created when a page or post URL changes)
- Markdown editor with assets drag/drop/paste support

## Local Setup

1. Clone the repo
2. Run `bin/setup` (you will need to have Ruby 3.3.4 installed)
3. Run `bin/dev`
4. Login at /admin. See below for creating your login account.

## Deployment

Provider steps are coming soon. For now, things to remember:
1. Ensure your database is backed up. There is a script (bin/backup) that will help you do this for you to S3. Livestream is coming soon.
1. I recommend using R2 for your assets, but any S3-compatible provider will work (or you can use local storage). You can configure this in `config/storage.yml`.
1. ENV variables you need to set:
  - `RAILS_MASTER_KEY` - This is used to encrypt the session cookie. You can generate a random key with `bin/rails secret`
  - `ACTIVE_STORAGE_SERVICE` - This is used to configure the storage service. **default: local**
  - `UPLOAD_PREFIX` - This is used to prefix uploaded files with a path. This is useful if you are using S3 for your assets. If you are using local storage, you can leave this blank. (only used with S3WithPrefixService)
  - `UPLOADED_ASSET_BASE_PATH` - This is used to prefix uploaded files with a path (only needed with an S3 compatible service. If you are using local storage, you can leave this blank.)
1. See below for instructions on how to create your login account.

## Creating Your Login Account

This may change, but for now, you can create an account with the following code in the Rails console:

```ruby
Author.create!(email: "YOUR_EMAIL", password: "YOUR_PASSWORD")
```

Alternatively, if there are no authors in the database or the only author is the seeded temp author, you can navigate to /admin and be prompted to create an author account. Once the author account is created, all others need to be done via the command line.

Also, note that there is no password reset functionality. I did not want to require working email, etc. Additional authors can be created via the command line, and passwords can be changed in the admin interface.

I am very open to suggestions on improving this while keeping it simple and minimizing dependencies.

## Testing

See the local setup above. Run `bin/rails test:all`

## Future Work

1. Theming
1. Shortcodes
1. Pushing content to X/Mastodon/Threads/etc
1. API / webhooks
1. Localization
1. Better code formatting
1. Better OG image support

## Shoutouts

There is a monumental amount of open source software that this project relies on. It is impossible to list them all, but there are a few that I am using directly that I want to call out and thank:

1. [Litestack](https://github.com/oldmoe/litestack) - Litestack is a lightweight, fast, and flexible web framework for Ruby on Rails.
1. [Flowbite](https://flowbite.com) - Flowbite is a library of accessible, free, and open source Tailwind CSS components (and of course Tailwind CSS itself).
1. [ViewComponentContrib](https://github.com/viewcomponent-contrib/view_component) - ViewComponentContrib is a collection of useful ViewComponent extensions.

[^1]: There are some interesting alternatives for hosting SQLite databases, and I hope to explore them shortly.