# frozen_string_literal: true

class Admin::Diff::Preview < ApplicationViewComponentPreview
  # You can specify the container class for the default template
  # self.container_class = "w-1/2 border border-gray-300"

  def default
    markdown = [Faker::Markdown.sandwich(sentences: 10), Faker::Markdown.sandwich(sentences: 10)].join("\n\n")
    new_markdown = replace_random_word_from_markdown(markdown)
    render(Admin::Diff::Component.new(old_value: markdown, new_value: new_markdown, attribute: "markdown", context: 3))
  end

  def title
    old_title = Faker::Lorem.words(number: 8).join(" ").titleize
    new_title = replace_random_word_from_markdown(old_title)
    render(Admin::Diff::Component.new(old_value: old_title, new_value: new_title, attribute: "title", context: 3))
  end

  private

  def replace_random_word_from_markdown(markdown)
    words = markdown.split(" ")
    old_word = words.sample
    new_word = Faker::Lorem.word
    markdown.gsub(old_word, new_word)
  end
end
