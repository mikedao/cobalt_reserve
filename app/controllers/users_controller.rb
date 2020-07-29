class UsersController < ApplicationController
  def new
  end

  def create
    new_user = User.new(user_params)

    if new_user.save
      flash[:success] = "Welcome, #{new_user.username}!"
      session[:user_id] = new_user.id
      redirect_to root_path
    else
      flash[:error] = new_user.errors.full_messages.join('. ')
      render :new
    end
  end

  def show
    @user = User.includes(:characters).find(session[:user_id])
    @character_list = @user.characters
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation, :first_name, :last_name, :email)
  end
end
