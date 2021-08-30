class ApplicationController < ActionController::Base
    helper_method :current_user
    helper_method :current_admin
    def current_user
        if session[:user_id]
          @current_user ||= User.find(session[:user_id])
        else
          @current_user = nil
        end
    end

    def current_admin 
        if session[:admin_user_id]
            @current_admin ||= User.find(session[:admin_user_id])
          else
            @current_admin = nil
        end
    end

end
