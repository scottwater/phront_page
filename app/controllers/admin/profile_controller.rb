# frozen_string_literal: true

class Admin::ProfileController < Admin::BaseController
  def edit
  end

  def update
    if Current.author.update(author_params)
      redirect_to edit_profile_path, notice: "Your profile has been updated"
    else
      render :edit
    end
  end

  private

  def author_params
    params.require(:author).permit(:name, :bio, :first_name, :last_name, :avatar_url, :time_zone)
  end
end
