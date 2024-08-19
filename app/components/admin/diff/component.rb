# frozen_string_literal: true

class Admin::Diff::Component < Admin::AdminViewComponent
  option :old_value
  option :new_value
  option :attribute
  option :context
end
