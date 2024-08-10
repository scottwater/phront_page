# frozen_string_literal: true

class Admin::Form::Revisions::Component < Admin::AdminViewComponent
  option :drawer_id
  option :klasses, optional: true
  option :revision_model_id
  option :revisions_model_type
end
