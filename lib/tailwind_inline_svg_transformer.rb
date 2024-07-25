# frozen_string_literal: true

class TailwindInlineSvgTransformer < InlineSvg::CustomTransformation
  def transform(doc)
    with_svg(doc) do |svg|
      klasses = svg&.classes || []
      klasses << value
      svg["class"] = TailwindMerge::Merger.new.merge(klasses)
    end
  end
end
