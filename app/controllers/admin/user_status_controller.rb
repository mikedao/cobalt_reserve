class Admin::UserStatusController < Admin::BaseController
  def update
    User.find(params[:id]).toggle!(:active)
    redirect_to admin_users_path
  end
end
