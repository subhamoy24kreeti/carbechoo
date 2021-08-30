class SessionController < ApplicationController
    def user_login
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          render "new"
          #redirect_to posts_path, notice: "Logged in!"
        else
          flash.now[:alert] = "Email or password is invalid"
          render "new"
        end
    end
    
    def admin_login
        admin = User.find_by_email(params[:email])
        if  !admin.blank? && admin.is_admin? && admin.authenticate(params[:password])
            session[:admin_user_id] = admin.id
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
