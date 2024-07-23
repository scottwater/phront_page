namespace :import do
  task micro_blog: :environment do
    Post.delete_all
    Redirect.delete_all
    author = Author.find_by!(email: "scottwater@gmail.com")
    shorts_page = Page.find_by!(name: "Shorts")
    find_md_files("/Users/scott/projects/mb_export").each do |file_path|
      data = parse_frontmatter(file_path)
      post = Post.new
      post.title = data[:title]&.strip
      post.markdown = data[:markdown].gsub("https://scottw.com/uploads/", "https://images.scottw.com/mb-images/")
      post.slug = data[:slug]
      post.published_at = data[:date]
      post.author = author
      if post.title.blank?
        post.page_id = shorts_page.id
      end
      puts "Importing #{file_path} with slug #{data[:slug]}"
      post.save!
      Redirect.create!(from: data[:url], to: post.slug)
    rescue ActiveRecord::RecordInvalid => e
      if e.message.include?("Validation failed: Slug has already been taken")
        post.slug = "#{data[:slug]}-#{SecureRandom.hex(4)}"
        post.save!
        Redirect.create!(from: data[:url], to: post.slug)
      else
        raise e
      end
    end
  end

  require "find"
  require "yaml"

  # Function to find all .md files in a given directory and its subdirectories
  def find_md_files(directory)
    md_files = []

    # Using Find to traverse the directory
    Find.find(directory) do |path|
      if File.file?(path) && File.extname(path) == ".md"
        md_files << path
      end
    end

    md_files
  end

  # Function to parse the frontmatter of a markdown file
  def parse_frontmatter(file_path)
    content = File.read(file_path)
    frontmatter, markdown = content.split("---", 3)[1..2].map(&:strip)

    # Parse the frontmatter using YAML
    data = YAML.load(frontmatter, permitted_classes: [Time, Date, Symbol], aliases: true)

    # Extract required values
    date = data["date"]
    url = data["url"]
    title = data["title"]
    slug = url.split("/").last.gsub(".html", "")

    {
      markdown:,
      date:,
      slug:,
      title:,
      url:
    }
  end
end
