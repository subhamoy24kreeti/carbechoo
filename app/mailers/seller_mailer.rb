class SellerMailer < ApplicationMailer

    default from: 'notifications@carbechoo.com'

    def welcome_mail(user)
        @user = user
        @url = "http://localhost:3000/seller/dashboard"
        mail(to: @user.email, subject: "successfully registred at carbechoo")
    end

    def email_verification_mail(user, verify_link)
        @user = user
        @verify_link = verify_link;
        mail(to: @user.email, subject: "email verification")
    end


end
