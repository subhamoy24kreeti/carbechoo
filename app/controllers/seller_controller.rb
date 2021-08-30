class SellerController < ApplicationController

    def new
       @seller = User.new 
       render 'signup'
    end

    def create
        seller = {}
        seller[:first_name] = params[:first_name]
        seller[:last_name] = params[:last_name]
        seller[:email] = params[:email]
        seller[:password] = params[:password]
        seller[:password_confirmation] = params[:password_confirmation]
        seller[:role] = 'seller'
        @seller = User.new(seller)
        if @user.save
            session[:user_id] = @seller.id
            flash[:notice] = "Successfully Created! account"
            redirect_to root_path
        else
            session[:user_id] = @seller.id
            flash[:alert] = "there is something wrong while creating account"
            render 'signup'
        end
    end

    def dashboard
        render 'user/dashboard'
    end
    def index

    end

    def destroy

    end

end
