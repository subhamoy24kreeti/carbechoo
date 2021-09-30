module ApplicationHelper

  def get_cities_dropdown
    City.all.map { |city| [city.name, city.id] }
  end

  def get_states_dropdown
    State.all.map { |state| [state.name, state.id]}
  end

  def get_countries_dropdown
    Country.all.map { |country| [country.name, country.id]}
  end

  def get_brands_dropdown
    Brand.all.map{|brand| [brand.brand_name, brand.id]}
  end

  def get_car_models_dropdown
    CarModel.all.map{|car_model| [car_model.name, car_model.id]}
  end

  def get_car_variants_dropdown
    CarVariant.all.map{|car_variant| [car_variant.variant, car_variant.id]}
  end

  def get_car_registrations_dropdown
    CarRegistration.all.map{|car_registration| [car_registration.state_code, car_registration.id]}
  end

  def get_killometer_drivens_dropdown
    KillometerDriven.all.map{|killometer_driven| [killometer_driven.killometer_range, killometer_driven.id]}
  end

  def get_cost_ranges_dropdown
    CostRange.all.map{|cost_range| [cost_range.name, cost_range.id]}
  end

  def get_cars
    SellerAppointment.where(status: 'approved')
  end

  def get_car_registration_years
    car_registration_year = CarRegistrationYear.first()
    years = []
    if !car_registration_year.blank?
      for year in car_registration_year.range1..car_registration_year.range2
        years.append([year, year])
      end
    end
    years
  end

  def get_statuses_dropdown
    [['processing',0], ['investigating', 1], ['approved', 2], ['rejecting', 3], ['sold out', 4]]
  end

end
