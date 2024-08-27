require "test_helper"

class Content::MarkdownTest < ActiveSupport::TestCase
  test "remove method handles basic markdown elements" do
    markdown = <<~MARKDOWN
      # Header

      This is **bold** and *italic* text.

      1. List item 1
      2. List item 2

      > Blockquote
    MARKDOWN

    expected = <<~EXPECTED
      Header

      This is bold and italic text.
    EXPECTED

    assert_equal expected.strip, Content::Markdown.remove(markdown).strip
  end

  test "remove method handles links" do
    markdown = <<~MARKDOWN
      This is a [link](https://example.com) and an [empty link]().

      Here's an [inline link with title](https://example.com "Example").
    MARKDOWN

    expected = <<~EXPECTED
      This is a link and an empty link.

      Here's an inline link with title.
    EXPECTED

    assert_equal expected.strip, Content::Markdown.remove(markdown).strip
  end

  test "remove method handles referenced links" do
    markdown = <<~MARKDOWN
      This is a [referenced link][ref1] and another [reference][ref2].

      [ref1]: https://example.com
      [ref2]: https://example.org "Example"
    MARKDOWN

    expected = <<~EXPECTED
      This is a referenced link and another reference.
    EXPECTED

    assert_equal expected.strip, Content::Markdown.remove(markdown).strip
  end

  test "remove method handles footnotes" do
    markdown = <<~MARKDOWN
      Here's a sentence with a footnote[^1].

      And another with a longer footnote[^bignote].

      [^1]: This is the first footnote.

      [^bignote]: This is a longer footnote with multiple paragraphs and code.

          Indent paragraphs to include them in the footnote.

          `{ my code }`

          Add as many paragraphs as you like.
    MARKDOWN

    expected = <<~EXPECTED
      Here's a sentence with a footnote.

      And another with a longer footnote.
    EXPECTED
    assert_equal expected.strip, Content::Markdown.remove(markdown).strip
  end

  test "remove method handles mixed markdown elements" do
    markdown = <<~MARKDOWN
      # My Document

      This paragraph has **bold**, *italic*, and `code` elements.

      Here's a [link](https://example.com) and a [referenced link][ref].

      > This is a blockquote with a [link](https://example.com).

      1. List item 1
      2. List item 2
         * Nested list item

      Here's an inline footnote[^inline] and a referenced one[^ref].

      [ref]: https://example.org
      [^inline]: This is an inline footnote.
      [^ref]: This is a referenced footnote.
    MARKDOWN

    expected = <<~EXPECTED
      My Document

      This paragraph has bold, italic, and code elements.

      Here's a link and a referenced link.

      Here's an inline footnote and a referenced one.
    EXPECTED

    assert_equal expected.strip, Content::Markdown.remove(markdown).strip
  end
end
