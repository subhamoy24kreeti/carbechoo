require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe "GET requests" do

    it "user should redirect to root when try to access profile if not login" do
      session[:user_id] = nil
      get :user_settings
      expect(response).to redirect_to(root_path)
    end

    it "user when not login can access landing page" do
      session[:user_id] = nil
      get :landing
      expect(response).to render_template('user/landing')
    end

    it "user when not login can access landing page" do
      session[:user_id] = 2
      get :landing
      expect(response).to_not  render_template('user/landing')
    end


  describe "PUT requests" do
    it "user should redirect to access root when try to update profile if not login" do
      session[:user_id] = nil
      put :user_profile_update
      expect(response).to redirect_to(root_path)
    end
  end

end