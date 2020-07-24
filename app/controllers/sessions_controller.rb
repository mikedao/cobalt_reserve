class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.username}!"
      redirect_to '/'
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :new
    end
  end
end
