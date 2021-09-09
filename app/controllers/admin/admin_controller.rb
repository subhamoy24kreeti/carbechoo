class Admin::AdminController < ApplicationController
    before_action :authorize_admin , except: [:get_login_page]

    def get_login_page
        render "admin/login";
    end

    def dashboard
        render "admin/dashboard"
    end

end
