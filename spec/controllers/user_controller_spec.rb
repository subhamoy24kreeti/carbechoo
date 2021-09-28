require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe "GET requests" do
    it "user should redirect to root when try to access profile if not login" do
      session[:user_id] = nil
      get :user_settings
      expect(response).to redirect_to(root_path)
    end
    it "user when not logged in  can access landing page" do
      session[:user_id] = nil
      get :landing
      expect(response).to render_template('user/landing')
    end

    it "user when logged in is unable access landing page" do
      session[:user_id] = 2
      get :landing
      expect(response).to_not  render_template('user/landing')
    end

    context "API testing" do
      describe "ws-get-states route" do
        before {get 'ws_get_states'}
        it 'returns all states with 200 status' do
          expect(response).to have_http_status(:success)
        end
      end
      describe "ws-get-cities route" do
        before {get 'ws_get_cities'}
        it 'returns all cities with 200 status' do
          expect(response).to have_http_status(:success)
        end
      end
      describe "ws-get-seller-profiles route" do
        before {get 'ws_get_seller_profiles'}
        it 'returns all cities with 200 status' do
          expect(response).to have_http_status(:success)
        end
      end

      describe "get-filter-cars-profiles route" do
        before {get 'get_filtered_cars'}
        it 'return filterd cars with 200 status' do
          expect(response).to have_http_status(:success)
        end
      end

      describe "check-status--appointment route" do
        before {get 'check_status_appointment'}
        it 'return check status appointment with 200 status' do
          expect(response).to have_http_status(:success)
        end
      end

    end

  end


  describe "PUT requests" do
    it "user should redirect to root when try to update profile if not login" do
      session[:user_id] = nil
      put :user_profile_update
      expect(response).to redirect_to(root_path)
    end
  end

end