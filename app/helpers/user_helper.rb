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
    upadte_user[:email] = params[:email]
    update_user[:zip_code] = params[:zip_code]
    update_user
  end

  def seller_formated(sellers)
    root_link = root_path
    sellers.map{|seller| {:id => seller.id, :profile_url => user_profile_path(seller.id), :profile_pic_url => (seller.cover_pic.attached?)?url_for(seller.profile_pic):(root_link+'assets/images/default_profile.png'), :about=> seller.about, :name => seller.full_name, :city => (seller.city ? seller.city.name : ""), :state => (seller.state ? seller.state.name : "") , :country => (seller.country ? seller.country.name : "")}}
  end

  def car_formated(cars)
    cars.map{|car| {:description => car.description, :price => car.get_price, :image_url => url_for(car.car_images[0]), :single_link => car_single_path(car.id) }}
  end

  def get_state_options(states)
    options = "<option value=''>--select your state--</option>"
    states.each do |state|
      options = options+ "<option value=#{state.id}>#{state.name}</option>"
    end
    options
  end

  def get_car_model_options(car_models)
    options = ""
    car_models.each do |car_model|
      options = options + "<option value=#{car_model.id}>#{car_model.name}</option>"
    end
    options
  end

  def get_city_options(cities)
    option = "<option value=''>--select your city--</option>"
    cities.each do |city|
      option = option + "<option value=#{city.id}>#{city.name}</option>"
    end
  end
end
