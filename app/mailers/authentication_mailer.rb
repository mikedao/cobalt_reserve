# mailer for passwordless authentication
class AuthenticationMailer < ApplicationMailer

  def send_login_email
    @character = params[:character]
    @user = @character.user
    @uuid = SecureRandom.uuid
    t = DateTime.now
    @user.update(login_uuid: @uuid, login_timestamp: t + 10.minutes)
    mail(to: @character.user.email,
         subject: "Action Required: The Cobalt Reserve is waiting for the return of #{@character.name}")
  end
end
