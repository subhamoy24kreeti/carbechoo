class SessionController < ApplicationController
  def user_login
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.is_seller?
        redirect_to seller_dashboard_path, flash: { notice: "successfully logged in seller" }
      else
        redirect_to buyer_dashboard_path, flash: { notice: "successfully logged in buyer" }
      end
      #redirect_to posts_path, notice: "Logged in!"
    else
      redirect_to user_login_get_path, flash: { error:  "Email or password is invalid" }
    end
  end

  def admin_login
    user = User.find_by_email(params[:email])
    if !user.blank? && user.is_admin? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_dashboard_path, flash: { notice: "Logged in!" }
    else
      render "admin/login", flash: { error:  "Email or password is invalid" }
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, flash: { notice: "Logged out!" }
  end
end
