class UserMailer < ApplicationMailer
  def notify_login(email, user_agent_string)
    @user_agent = UserAgent.parse(user_agent_string)

    mail to: email, subject: 'Nuevo inicio de sesión en Acid'
  end
end
