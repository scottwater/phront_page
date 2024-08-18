class Admin::RevisionPresenter < Keynote::Presenter
  presents :revision
  delegate :id, :record_type, to: :revision

  def title
    revision.attributes_with_changes&.dig("name", 1).presence ||
      revision.attributes_with_changes&.dig("title", 1).presence ||
      revision.data&.dig("title").presence ||
      revision.data&.dig("name").presence ||
      revision.data&.dig("summary")&.truncate(50) ||
      "No title/name"
  end

  def svg_icon_name
    revision.auto_revision? ? "compare_auto" : "compare"
  end

  def saved_at
    revision.created_at.strftime("%B %d, %Y at %I:%M %p")
  end

  def saved_at_description
    "#{revision.auto_revision? ? "Saved at" : "Published at"} #{saved_at}"
  end

  def changes
    revision.attributes_with_changes.reject { |key, value| key.in?(["html", "id", "created_at", "updated_at"]) }
  end

  def changes?
    changes.any?
  end

  def edit_path
    case [revision.record, revision.record_type]
    in [Post => post, "Post"]
      edit_post_path(post, revision: revision.id)
    in [Page => page, "Page"]
      edit_page_path(page, revision: revision.id)
    in [nil, "Post"]
      new_post_path(revision: revision.id)
    in [nil, "Page"]
      new_page_path(revision: revision.id)
    else
      raise "Unknown record type"
    end
  end

  def change_list
    revision
      .attributes_with_changes
      .keys
      .reject { |attr| %w[html id created_at updated_at].include?(attr) }
      .map { |attr| attr.to_s.titleize }
      .tap { |keys| keys << "No changes detected" if keys.empty? }
      .join(", ")
  end
end
