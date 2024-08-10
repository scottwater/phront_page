# frozen_string_literal: true

class Admin::RevisionOrphans::Component < Admin::AdminViewComponent
  option :orphans
  option :record_type

  def render?
    orphans&.any?
  end
end
