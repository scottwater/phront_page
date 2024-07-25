# frozen_string_literal: true

ActiveRecord::Base.class_eval do
  include ActiveModel::Validations

  def self.validates_not_reserved_path(*attr_names)
    validates_with NotReservedPathValidator, _merge_attributes(attr_names)
  end
end
