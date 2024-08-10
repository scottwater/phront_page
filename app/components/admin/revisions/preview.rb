# frozen_string_literal: true

class Admin::Revisions::Preview < ApplicationViewComponentPreview
  # You can specify the container class for the default template
  # self.container_class = "w-1/2 border border-gray-300"

  # @param post_id number "The ID of the post to display"
  # @param page_id number "The ID of the page to display"
  # @param uid text "A UID to display"
  def default(post_id: nil, page_id: nil, uid: nil)
    revisions = post_revsion(post_id) || page_revsion(page_id) || revisions_by_uid(uid) || random_revisions
    render(Admin::Revisions::Component.new(revisions:))
  end

  private

  def random_revisions
    r = Revision.last
    if r.record
      r.record.revisions.order(created_at: :desc).limit(10)
    else
      Revision.where(uid: r.uid).order(created_at: :desc).limit(10)
    end
  end

  def revisions_by_uid(uid)
    return unless uid.present?
    Revision.where(uid:).order(created_at: :desc).limit(10)
  end

  def post_revsion(post_id)
    return nil unless post_id.present?
    post = Post.find(post_id)
    post.revisions.order(created_at: :desc).limit(10)
  end

  def page_revsion(page_id)
    return nil unless page_id.present?
    page = Page.find(page_id)
    page.revisions.order(created_at: :desc).limit(10)
  end
end
