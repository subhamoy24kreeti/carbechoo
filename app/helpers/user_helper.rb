module UserHelper
  def my_appointments_link(path)
    link_to ('<i class="fa fa-calendar"></i>my appointments').html_safe, path, class: "dropdown-item"
  end

  def seller_store_link(path)
    link_to ('<i class="fas fa-store"></i>sellers').html_safe, path, class: "dropdown-item"
  end

  def user_settings_link(path)
    link_to ('<i class="fa fa-cog"></i> Settings').html_safe, path, class:"dropdown-item"
  end

  def update_user_profile_params_check(params)
    update_user = {}
    update_user[:first_name] = params[:first_name]
    update_user[:last_name] = params[:last_name]
    update_user[:country_id] = params[:country_id]
    update_user[:state_id] = params[:state_id]
    update_user[:city_id] = params[:city_id]
    update_user[:phone] = params[:phone]
    update_user[:zip_code] = params[:zip_code]
    update_user
  end
end
