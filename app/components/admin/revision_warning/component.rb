# frozen_string_literal: true

class Admin::RevisionWarning::Component < Admin::AdminViewComponent
  option :revision, optional: true

  def render?
    !!revision
  end
end
