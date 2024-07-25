# frozen_string_literal: true

module Post::Content
  extend ActiveSupport::Concern

  included do
    before_validation :generate_html
    after_validation :generate_summary
    before_validation :set_title_less_page_id
  end

  def set_title_less_page_id
    if title.blank? && page_id.blank? && (title_less_page_id = Config::Blog.new.content.title_less_page_id.presence)
      self.page_id = title_less_page_id
    end
  end

  def published?
    published_at.present? && published_at <= Time.current
  end

  def generate_html
    self.html = Content::Markdown.to_html(markdown) if markdown
  end

  def generate_summary
    return unless markdown
    if markdown&.include?("<!--more-->")
      self.summary = Content::Markdown.remove(markdown.split("<!--more-->").first)
    elsif summary.blank?
      self.summary = truncate_sentence(Content::Markdown.remove(markdown))
    end
  end

  def truncate_sentence(text, max_length = 300)
    return text if text.length <= max_length

    sentences = text.split(/(?<=\.)/)
    truncated_text = sentences.shift

    sentences.each do |sentence|
      if (truncated_text + sentence).length > max_length
        break
      end
      truncated_text += sentence
    end

    truncated_text.strip
  end
end
