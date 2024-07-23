module BlogHelper
  def navigation_pages
    @navigation_pages ||= Page.navigation
  end

  def search_path
    "/search"
  end

  def social_networks
    @social_networks ||= [].tap do |networks|
      Config::Blog::Socials.networks.each do |network|
        username = Current.blog_config.socials.data["#{network}_username"]
        url = Current.blog_config.socials.data["#{network}_url"]
        if username.present? && url.present?
          networks << {name: network, username: username, url: url}
        end
      end
    end
  end
end
