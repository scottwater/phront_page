# PhrontPage

**Warning**: _This is a work in progress. It is at the stage that it hits many of my personal goals, but I expect it to continue to evolve, especially if others are interested in using and contributing to it._

PhrontPage is a Rails application using the Litestack stack. You can host it anywhere you can host a Rails app (that provides persistent storage for the database[^1]).

I have built (.Text, CommunityServer, GraffitiCMS) and used (Octopress, Jekyll, 11ty, Micro.blog, Wordpress, Radio) a wide variety of blogging applications in the past. I wanted to build a blogging application that was simple, easy to host/deploy/update/maintain, and that I could use to write and publish my own content.

Core Wants:

* Simple to use, easy to host/deploy/update/maintain
* Dynamic, not static
* Minimal interface
* Act as a personal content hub. Eventualy, I would like content to start here and then be distributed to X/Mastodon/Threads/etc.


## Current Main Feature Set
- Pages
- Posts
- Posts can be published to pages
- Built in search (Litestack!)
- Built in redirects (you can define them, automatically created when a page or post URL changes)
- Markdown editor with assets drag/drop/paste support

## Local Setup

1. Clone the repo
2. Run `bin/setup` (you will need to have Ruby 3.3.4 installed)
3. Run `bin/dev`
4. Login at /admin. See below for creating your login account.

## Deployment

Provider steps coming soon. For now things to remmember:
1. Ensure your database is backed up. There is a script (bin/backup) that will help you do this for you to S3. LiteStream coming soon.
1. I recommend using R2/S3 for your assets. You can configure this in `config/storage.yml`.
1. ENV variables you need to set:
  - `RAILS_MASTER_KEY` - This is used for encrypting the session cookie. You can generate a random key with `bin/rails secret`
  - `ACTIVE_STORAGE_SERVICE` - This is used to configure the storage service.
  - `UPLOAD_PREFIX` - This is used to prefix uploaded files with a path. This is useful if you are using S3 for your assets. If you are using local storage, you can leave this blank. (only used with S3WithPrefixService)
  - `UPLOADED_ASSET_BASE_PATH` - This is used to prefix uploaded files with a path (only needed with an S3 compatible service. If you are using local storage, you can leave this blank.)
1. See below for creating your login account.

## Creating Your Login Account

This may change, but for now you can create an account with the following code in the Rails console:

```ruby
Author.create!(email: "YOUR_EMAIL", password: "YOUR_PASSWORD")
```

Alternatively, if there are no authors in the database or the only author is the seeded temp author, you can navigate to /admin and you will be prompted to create an author account. Once the author account is created all others need to be done via the command line.

Also note, there is no password reset functinality. I did not want to require working email/etc. Additional authors can be created via the command line. Passwords can be changed in the admin interface.

I am very open to suggestions for how to improve this while keepping it simple and dependency lite.

## Testing

See local setup above. Run `bin/rails test:all`

## Future Work

1. Theming
1. Shortcodes
1. Pushing content to X/Mastodon/Threads/etc
1. API / webhooks
1. Localization
1. Better code formatting
1. Better OG image support

[^1]: There are some interesting alternatives for hosting SQLite databases and I hope to explore them shortly.