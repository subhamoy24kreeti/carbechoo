class BuyerController < ApplicationController
    def new
        @buyer = User.new
        render 'signup'
    end

    def create
        buyer = {}
        buyer[:first_name] = params[:first_name]
        buyer[:last_name] = params[:last_name]
        buyer[:email] = params[:email]
        buyer[:password] = params[:password]
        buyer[:password_confirmation] = params[:password_confirmation]
        buyer[:role] = 'buyer'
        @buyer = User.new(buyer)
        if @buyer.save
            session[:user_id] = @buyer.id
            flash[:notice] = "Successfully Created! account"
            redirect_to root_path
        else
            session[:user_id] = @buyer.id
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
        User.destroy(params[:id])
    end
end
