class UserMailer < ApplicationMailer

  def forget_password_change_mail(user)
    @user = user
    mail(to: @user.email, subject: "forget Password changed")
  end

  def email_verification_mail(user)
    @user = user
    mail(to: @user.email, subject: "Email verification")
  end
end
