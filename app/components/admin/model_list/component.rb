# frozen_string_literal: true

class Admin::ModelList::Component < Admin::AdminViewComponent
  renders_many :headers, "HeaderComponent"
  renders_many :rows, "RowComponent"
  option :button_text, optional: true
  option :button_url, optional: true

  def new_button?
    button_text.present? && button_url.present?
  end

  class HeaderComponent < Admin::AdminViewComponent
    option :title, optional: true

    def call
      content_tag :th, scope: "col", class: "px-4 py-3" do
        content || title
      end
    end
  end

  class RowComponent < Admin::AdminViewComponent
    renders_many :cells, "CellComponent"
    renders_many :actions, "ActionComponent"

    def call
      tds = cells.map.with_index do |cell, index|
        if index == 0
          cell.call("px-4 py-3 font-medium text-gray-900 whitespace-nowrap dark:text-white")
        else
          cell.call("px-4 py-3")
        end
      end
      tds << action_td
      content_tag :tr, class: "border-b dark:border-gray-700" do
        tds.join.html_safe
      end
    end

    def action_td
      content_tag :td, class: "px-4 py-3 flex items-center justify-start" do
        actions.map(&:call).join.html_safe
      end
    end

    class CellComponent < Admin::AdminViewComponent
      def call(classes = nil)
        content_tag :td, content, class: classes
      end
    end

    class ActionComponent < Admin::AdminViewComponent
      option :text
      option :url
      option :classes, optional: true

      def call
        if url
          link_to text, url, class: "ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium", **attributes
        else
          content_tag :span, text, class: "ml-2 py-3 px-5 inline-block font"
        end
      end
    end
  end
end
