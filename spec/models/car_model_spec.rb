require 'rails_helper'

RSpec.describe CarModel, type: :model do
  subject { build(:car_model) }

  before {subject.save}
  context 'model ame' do
    it 'should be present ' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

  context 'relation check' do
    it 'brand_id should be present' do
      subject.brand_id = nil
      expect(subject).to_not be_valid
    end
  end
end