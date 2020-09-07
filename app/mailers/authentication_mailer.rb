# mailer for passwordless authentication
class AuthenticationMailer < ApplicationMailer

  def send_login_email
    @user = params[:user]
    @uuid = SecureRandom.uuid
    t = DateTime.now
    @user.update(login_uuid: @uuid, login_timestamp: t + 10.minutes)
    mail(
      to: @user.email,
      subject: "Action Required: #{@user.username}, Turing West Marches awaits your return!"
    )
  end
end
