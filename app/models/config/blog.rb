class Config::Blog
  def socials = (@socials ||= Config.get("blog/socials"))

  def meta = (@meta ||= Config.get("blog/meta"))

  def settings = (@settings ||= Config.get("blog/settings"))

  def content = (@content ||= Config.get("blog/content"))
end
