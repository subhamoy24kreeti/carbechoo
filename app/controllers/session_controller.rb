class SessionController < ApplicationController
  def user_login
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.role.eql?'seller'
        redirect_to seller_dashboard_path, notice: "successfully logged in seller"
      else
        redirect_to buyer_dashboard_path, notice: "successfully logged in buyer"
      end
      #redirect_to posts_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"
      redirect_to user_login_get_path
    end
  end

  def admin_login
    user = User.find_by_email(params[:email])
    if !user.blank? && user.is_admin? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_dashboard_path, notice: "Logged in!"
    else
      flash.now[:error] = "Email or password is invalid"
      render "admin/login"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
