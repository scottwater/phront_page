# frozen_string_literal: true

module Redirect::Content
  extend ActiveSupport::Concern

  included do
    after_update :create_slug_redirect, if: :slug_previously_changed?
  end

  def create_slug_redirect
    if slug_previously_was.present? && slug_previously_was != slug
      Redirect.upsert({from: slug_previously_was, to: slug}, unique_by: :from)
    end
  end
end
