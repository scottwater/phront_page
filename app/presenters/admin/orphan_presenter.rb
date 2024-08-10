class Admin::OrphanPresenter < Admin::RevisionPresenter
  def uid
    revision.uid
  end
end
