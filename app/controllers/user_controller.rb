class UserController < ApplicationController

    def landing
        @cities = City.all.map{|city| [city.name, city.id]}
        @car_models = CarModel.all.map{|car_model| [car_model.name, car_model.id]}
        @brands = Brand.all.map{|brand| [brand.brand_name, brand.id]}
        @car_registrations = CarRegistration.all.map{|car_registration| [car_registration.state_code, car_registration.id]}
        @car_variants = CarVariant.all.map{|car_variant| [car_variant.variant, car_variant.id]}
        render 'landing'
    end

    def car_single
        id = params[:id];
        @seller_appointment = SellerAppointment.find_by_id(id);
        render 'car_single'
    end

    def ws_get_cities
        @cities = City.where(state_id: params[:state_id])
        option = "<option value=''>--select your city--</option>"
        @cities.each do |city|
            option = option + "<option value=#{city.id}>#{city.name}</option>"
        end
        render json: {html: option}
    end

    def ws_get_states
        @states = State.where(country_id: params[:country_id])
        option = "<option value=''>--select your state--</option>"
        @states.each do |state|
            option = option + "<option value=#{state.id}>#{state.name}</option>"
        end
        render json: {html: option}
    end

    def login
        render 'login'
    end

end
