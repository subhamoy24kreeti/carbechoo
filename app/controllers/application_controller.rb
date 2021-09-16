class ApplicationController < ActionController::Base
    helper_method :current_user
    helper_method :authorize_admin
    def current_user
        if session[:user_id]
          @current_user ||= User.find(session[:user_id])
        else
          @current_user = nil
        end
    end

    def authorize_admin
      if current_user.blank?
          redirect_to main_app.root_path
      else
          redirect_to main_app.root_path unless current_user.is_admin?
      end
    end

    def authorize_user
      if current_user.blank?
          redirect_to main_app.root_path
      end
    end
end
