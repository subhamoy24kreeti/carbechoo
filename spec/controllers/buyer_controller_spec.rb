require 'rails_helper'

RSpec.describe BuyerController, type: :controller do
  describe "GET requests" do

    it "should not be access by not login user" do
      session[:user_id] = nil
      get :add_car_details
      expect(response).to_not render_template('buyer/add_car_details')
    end

    it "buyer dashboard is not access by not login user" do
      session[:user_id] = nil
      get :dashboard
      expect(response).to_not render_template('buyer/dashboard')
    end

  end
end