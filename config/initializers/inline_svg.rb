# frozen_string_literal: true

require "./lib/tailwind_inline_svg_transformer"
InlineSvg.configure do |config|
  config.add_custom_transformation(attribute: :class, transform: TailwindInlineSvgTransformer)
end
