# frozen_string_literal: true

module Content::Markdown
  extend self

  def to_html(markdown,
    options: {extension: {footnotes: true, description_lists: true, multiline_block_quotes: true}, render: {unsafe: true}},
    plugins: {syntax_highlighter: {theme: "base16-ocean.dark"}})
    Commonmarker.to_html(markdown, options:, plugins:)
  end

  def remove(markdown)
    markdown.dup.tap do |md|
      # Remove links but keep the link text
      md.gsub!(/\[([^\]]+)\]\([^\)]+\)/, '\1')

      # Remove images
      md.gsub!(/!\[[^\]]*\]\([^\)]+\)/, "")

      # Remove code blocks (indented, fenced with three backticks, and optionally fenced with three backticks and the language name)
      md.gsub!(/(^|\n)```.*?\n.*?\n```(\n|$)/m, "")
      md.gsub!(/(^|\n)    .+(\n|$)/, "")

      # Remove blockquotes
      md.gsub!(/(^|\n)> .+(\n|$)/, "")

      # Remove ordered and unordered lists
      md.gsub!(/(^|\n)\s*[-+*]\s+.+(\n|$)/, "")
      md.gsub!(/(^|\n)\s*\d+\.\s+.+(\n|$)/, "")

      # Remove markdown footnotes
      md.gsub!(/(^|\n)\[\^[^\]]+\]: .+(\n|$)/, "")

      # Remove other markdown syntax but keep the content
      md.gsub!(/(\*\*|__)(.*?)\1/, '\2')  # Bold
      md.gsub!(/(\*|_)(.*?)\1/, '\2')     # Italic
      md.gsub!(/(~~)(.*?)\1/, '\2')       # Strikethrough
      md.gsub!(/`{2}([^`]+)`{2}/, '\1')   # Inline code with double backticks
      md.gsub!(/^#+\s+/, "")              # Headers
      md.gsub!(/^\s*[-*_]{3,}\s*$/, "")   # Horizontal rules

      # Remove any remaining markdown syntax like inline links/images that may have slipped through
      md.gsub!(/[`*_{}\[\]()#+]/, "")

      # Remove image metadata
      md.gsub!(/^!.+$/, "")

      # normalize newlines
      md.gsub!(/\n{2,}/, "\n\n")
    end
  end
end
