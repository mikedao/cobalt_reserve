class StatusController < ApplicationController
  def update
    User.find(params[:id]).toggle!(:active)
    session[:user_id] = nil
    flash[:success] = 'You have successfully disabled your account and logged out.'
    redirect_to root_path
  end
end
