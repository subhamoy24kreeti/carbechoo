require 'rails_helper'

RSpec.describe CarRegistration, type: :model do
  subject { build(:car_registration) }

  before {subject.save}
  context 'state code' do
    it 'should be present ' do
      subject.state_code = nil
      expect(subject).to_not be_valid
    end
  end
end