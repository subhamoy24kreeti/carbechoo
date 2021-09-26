require 'rails_helper'

RSpec.describe CarModel, type: :model do
  subject { build(:car_model) }

  before {subject.save}
  it 'cost range -> quality should not be nil' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
end