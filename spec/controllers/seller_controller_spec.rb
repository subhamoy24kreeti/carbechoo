require 'rails_helper'

RSpec.describe SellerController, type: :controller do
  describe "GET requests" do


    it "add car details should not be access by not login user" do
      session[:user_id] = nil
      get :add_car_details
      expect(response).to_not render_template('seller/add_car_details')
    end

    it "seller dashboard is not access by not login user" do
      session[:user_id] = nil
      get :dashboard
      expect(response).to_not render_template('seller/dashboard')
    end

  end
end