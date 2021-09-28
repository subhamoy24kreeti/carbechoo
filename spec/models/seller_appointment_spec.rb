require 'rails_helper'

RSpec.describe SellerAppointment , type: :model do
  subject { build(:seller_appointment) }

  before {subject.save}
  it 'user_id should be present' do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'brand_id should be present' do
    subject.brand_id = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'car_model_id should be present' do
    subject.car_model_id = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'car_registration_id should be present' do
    subject.car_registration_id = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'killometer_driven_id should be present' do
    subject.killometer_driven_id = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'car_variant_id should be present' do
    subject.car_variant_id = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'city_id should be present' do
    subject.city_id = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'state_id should be present' do
    subject.state_id = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'country_id should be present' do
    subject.country_id = nil
    expect(subject).to_not be_valid
  end

  it 'year_of_buy should be present' do
    subject.year_of_buy = nil
    expect(subject).to_not be_valid
  end

  it 'price should be present' do
    subject.price = nil
    expect(subject).to_not be_valid
  end
end