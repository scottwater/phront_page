class FeedController < ApplicationController
  include BlogConfiguration
  def index
    @posts = Post.root_feed

    last_modified = [@posts.maximum(:updated_at), @posts.maximum(:published_at)].min
    if stale?(etag: @posts, last_modified: last_modified)
      @posts = helpers.present_all(@posts, :feed)
      respond_to do |format|
        format.xml { render layout: false }
        format.rss { render :index, formats: [:xml], handlders: [:builder], layout: false }
        format.json { render json: atom_feed_json }
        format.atom { render json: atom_feed_json }
      end
    end
  end

  def atom_feed_json
    {
      version: "https://jsonfeed.org/version/1.1",
      title: Current.blog_config.meta.title,
      home_page_url: Current.blog_config.settings.base_url,
      feed_url: feed_url(format: :json),
      items: @posts.map do |post|
        {
          id: post.url,
          title: post.title,
          content_html: post.html,
          url: post.url,
          date_published: post.published_at
        }.keep_if { |_, v| v.present? }
      end
    }
  end
end
