class UserMailer < ApplicationMailer
  def password_reset(user, raw_token)
    @user = user
    @raw_token = raw_token
    mail to: user.employee.email, subject: "Password Reset Instructions"
  end
end