module BuyerHelper

  def check_buyer_params(params)
    buyer = {}
    buyer[:first_name] = params[:first_name]
    buyer[:last_name] = params[:last_name]
    buyer[:email] = params[:email]
    buyer[:password] = params[:password]
    buyer[:password_confirmation] = params[:password_confirmation]
    buyer[:role] = 'buyer'
    buyer[:country_id] = params[:country_id]
    buyer[:state_id] = params[:state_id]
    buyer[:city_id] = params[:city_id]

    buyer[:zip_code] = params[:zip_code]
    buyer
  end


  private

  def buyer_authorization
    if current_user.blank?
      redirect_to root_path and return
    end
    if current_user.is_seller?
      redirect_to seller_dashboard_path and return
    end
  end
end
