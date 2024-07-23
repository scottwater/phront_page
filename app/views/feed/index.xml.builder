xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title Current.blog_config.meta.title
    xml.description Current.blog_config.meta.subtitle
    xml.link Current.blog_config.settings.base_url

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.html
        xml.pubDate post.published_at
        xml.link post.url
        xml.guid post.url
      end
    end
  end
end
