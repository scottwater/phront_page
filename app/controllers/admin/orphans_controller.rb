class Admin::OrphansController < Admin::BaseController
  def index
    @orphans = Revision.orphaned_items_last(record_type: params[:type].classify)
  end

  def delete
    Revision.where(record_type: params[:type].classify, uid: params[:uid]).delete_all
    redirect_to orphaned_items_path("#{params[:type].downcase}s"), notice: "The items were deleted", status: :see_other
  end
end
