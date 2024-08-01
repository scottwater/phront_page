# frozen_string_literal: true

class Admin::Form::Drawer::Component < Admin::AdminViewComponent
  option :id
  option :text, optional: true
  option :position, default: proc { :right }
  def style
    horizontal = %i[left right].include?(position)
    vertical = %i[top bottom].include?(position)
    super(position:, horizontal:, vertical:)
  end
  # TODO - There is an issue with Bottom position. It will render the drawer open by default
  # TailwindCSS is not picking up classes when they are on the same line in this file
  style do
    base {
      %w[
        fixed
        z-40
        p-4
        transition-transform
        bg-white
        dark:bg-gray-800
      ]
    }
    variants {
      position {
        left {
          %w[
            top-16
            left-0
            border-r
            -translate-x-full
          ]
        }
        right {
          %w[
            top-16
            right-0
            translate-x-full
            border-l
          ]
        }
        top {
          %w[
            top-0
            left-0
            right-0
            -translate-y-full
          ]
        }
        bottom {
          %w[
            bottom-0
            left-0
            right-0
            overflow-y-auto
            transform-none
          ]
        }
      }
      horizontal {
        yes {
          %w[
            h-screen
            overflow-y-auto
            w-full
            sm:w-3/4
            lg:w-1/2
            border-gray-200
          ]
        }
      }
      vertical {
        yes {
          %w[
            w-full
          ]
        }
      }
    }
  end
end
