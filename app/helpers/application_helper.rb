module ApplicationHelper

  def get_cities_dropdown(state_id)
    City.city_map(state_id)
  end

  def get_all_cities_dropdown
    City.all_city_map
  end

  def get_all_states_dropdown
    State.all_state_map
  end

  def get_states_dropdown(country_id)
    City.state_map(country_id)
  end

  def get_countries_dropdown
    Country.get_country_map
  end

  def get_brands_dropdown
    Brand.brand_map
  end

  def get_car_models_dropdown
    CarModel.car_model_map
  end

  def get_car_variants_dropdown
    CarVariant.car_variant_map
  end

  def get_car_registrations_dropdown
    CarRegistration.car_registration_map
  end

  def get_killometer_drivens_dropdown
    KillometerDriven.killometer_driven_map
  end

  def get_cost_ranges_dropdown
    CostRange.cost_range_map
  end

  def get_cars
    SellerAppointment.cars
  end

  def get_car_registration_years
    CarRegistrationYear.year_map
  end

  def get_statuses_dropdown
    [['processing',0], ['investigating', 1], ['approved', 2], ['rejecting', 3], ['sold out', 4]]
  end

end
