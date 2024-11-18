module Search
  extend ActiveSupport::Concern

  private def update_search_index
    fts_model = "Fts#{self.class.name}".constantize
    search_attrs = self.class.search_scope_attributes.each_with_object({}) { |attr, acc|
      acc[attr] = send(attr) || ""
    }

    # Delete existing FTS record
    fts_model.where(self.class.fts_foreign_key => id).delete_all

    # Insert new FTS record using the model
    fts_model.create!(
      search_attrs.merge(
        self.class.fts_foreign_key => id
      )
    )
  end

  private def delete_search_index
    fts_model = "Fts#{self.class.name}".constantize
    fts_model.where(self.class.fts_foreign_key => id).delete_all
  end

  included do
    after_save_commit :update_search_index
    after_destroy_commit :delete_search_index

    scope :search, ->(query) {
      return none if query.blank?
      fts_model = "Fts#{name}".constantize
      fts_records = fts_model.where("#{fts_model.table_name} MATCH ?", query)
      where(id: fts_records.select(fts_foreign_key))
    }
  end

  class_methods do
    def search_scope(*attrs)
      @search_scope_attrs = attrs
    end

    def search_scope_attributes
      @search_scope_attrs || []
    end

    def rebuild_search_index(*ids)
      target_ids = Array(ids)
      target_ids = self.ids if target_ids.empty?
      fts_model = "Fts#{name}".constantize

      # Clear existing FTS records for the target ids
      if target_ids.any?
        fts_model.where(fts_foreign_key => target_ids).delete_all
      else
        fts_model.delete_all
      end

      # Rebuild FTS records
      target_ids.each do |id|
        record = where(id: id).pick(*search_scope_attributes, :id)
        if record.present?
          id = record.pop
          attrs = search_scope_attributes.zip(record).to_h
          fts_model.create!(
            attrs.merge(fts_foreign_key => id)
          )
        end
      end
    end

    def fts_foreign_key
      name.underscore + "_id"
    end
  end
end
