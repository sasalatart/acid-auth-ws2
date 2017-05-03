class UserMailer < ApplicationMailer
  def notify_login(email, user_agent_string, success)
    @user_agent = UserAgent.parse(user_agent_string)
    @success = success

    subject_header = success ? 'Nuevo ' : 'Intento fallido de '

    mail to: email, subject: "#{subject_header} inicio de sesión en Acid"
  end
end
