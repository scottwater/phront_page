# frozen_string_literal: true

require "test_helper"

class Content::EmbeededSvgServiceTest < ActiveSupport::TestCase
  def original = <<~SVG
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="px-6 lucide lucide-banana"><path d="M4 13c3.5-2 8-2 10 2a5.5 5.5 0 0 1 8 5"/><path d="M5.15 17.89c5.52-1.52 8.65-6.89 7-12C11.55 4 11.5 2 13 2c3.22 0 5 5.5 5 8 0 6.5-4.2 12-10.49 12C5.11 22 2 22 2 20c0-1.5 1.14-1.55 3.15-2.11Z"/></svg>
  SVG

  test "with no classes, just return the original" do
    svg = Content::EmbeddedSvg.merge(original)
    assert_equal original, svg
  end

  test "add additional classes to the svg" do
    svg = Content::EmbeddedSvg.merge(original, "px-4 py-4")
    doc = Nokogiri::HTML::DocumentFragment.parse(svg)
    assert_equal "lucide lucide-banana px-4 py-4", doc.at_css("svg")["class"]
  end

  test "a svg with no classes gets only our new classes" do
    test_svg = <<~SVG
      <svg xmlns="http://www.w3.org/2000/svg" />
    SVG
    refute_match(/class/, test_svg)
    svg = Content::EmbeddedSvg.merge(test_svg, "px-4 py-4")
    assert_match(/class/, svg)
    assert_match(/px-4 py-4/, svg)
  end
end
