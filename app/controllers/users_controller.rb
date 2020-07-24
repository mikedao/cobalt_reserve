class UsersController < ApplicationController
  def new
  end

  def create
    new_user = User.create(user_params)
    flash[:success] = "Welcome, #{new_user.username}!"
    redirect_to root_path
  end

  private
  def user_params
    params.permit(:username, :password, :first_name, :last_name, :email)
  end
end
