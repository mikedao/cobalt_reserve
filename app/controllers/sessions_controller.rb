class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.username}!"
      if user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to '/profile'
      end
    else
      flash[:error] = 'Sorry, your credentials are bad.'
      render :new
    end
  end

  def passwordless_new
    @users = User.select(:id, :username).where.not(status: 'inactive').order(:username)
  end

  def passwordless_create
    user = User.where(id: params['user-select']).where.not(status: 'inactive').first
    if !user.nil?
      user.update!(login_uuid: SecureRandom.uuid, login_timestamp: DateTime.now)
      AuthenticationMailer.with(user: user).send_login_email.deliver_now
      render :passwordless_check_email and return
    else
      redirect_to :passwordless_login and return
    end
  end

  def passwordless_return
    @user = User.where(login_uuid: params[:login_uuid]).first

    if @user
      if uuid_timestamp_valid
        session[:user_id] = @user.id
        flash[:success] = "Welcome, #{@user.username}!"
        redirect_to profile_path and return
      else
        flash[:error] = 'Sorry, that login link has expired. Please log in again.'
      end
    else
      flash[:error] = 'Sorry, I have no idea who you are. Please log in again.'
    end
    render :new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have successfully logged out.'
    redirect_to root_path
  end

  def uuid_timestamp_valid
    DateTime.now <= @user.login_timestamp + 10.minutes
  end
end
