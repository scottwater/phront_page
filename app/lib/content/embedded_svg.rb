module Content::EmbeddedSvg
  extend self
  def merge(svg, klass = nil)
    if klass
      doc = Nokogiri::HTML::DocumentFragment.parse(svg)
      if (svg_element = doc.at_css("svg"))
        if (klasses = svg_element.classes)
          klasses << klass
          svg_element["class"] = TailwindMerge::Merger.new.merge(klasses.flatten.uniq)
        end
      end
      doc.to_s
    else
      svg
    end
  end
end
