class Admin::AccountController < Admin::BaseController
  def edit
    @author = Current.author
  end

  def update
    @author = Author.find(Current.author.id)
    account_form = AccountForm.new(author: @author, params: author_params)
    if account_form.save
      redirect_to admin_root_path, notice: "Your account has been updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def author_params
    params.require(:author).permit(:password, :new_password, :confirm_new_password, :email)
  end
end
