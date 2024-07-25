# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  scope :ordered, -> { order(id: :desc) }
  scope :randomized, -> { order("RANDOM()") }

  PagedData = Data.define(:all_records, :offset) do
    def records
      all_records[0, offset]
    end

    def next?
      !!all_records[offset]
    end
  end

  scope :paged, ->(paging_id: 1, size: 10) {
    query = limit(size + 1).offset((paging_id.to_i - 1) * size)
    PagedData.new(query.to_a, size)
  }
end
