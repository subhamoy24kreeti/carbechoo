class Admin::AdminController < ApplicationController
    before_action :authorize_admin , except: [:get_login_page]

    def authorize_admin
        if current_admin.blank?
            redirect_to main_app.root_path
        else
            redirect_to main_app.root_path unless current_admin.is_admin?
        end
    end

    def get_login_page
        render "admin/login";
    end

    def dashboard
        render "admin/dashboard"
    end

end
