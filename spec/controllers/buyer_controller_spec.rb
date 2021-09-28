require 'rails_helper'

RSpec.describe BuyerController, type: :controller do
  describe "GET requests" do

    it "seller unable to access buyer dashboard" do
      session[:user_id] = 2
      get :dashboard
      expect(response).to_not render_template('buyer/dashboard')
    end

    it "buyer unable to access buyer dashboard" do
      session[:user_id] = 3
      get :dashboard
      expect(response).to render_template('buyer/dashboard')
    end

  end
end