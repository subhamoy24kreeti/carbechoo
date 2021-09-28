require 'rails_helper'

RSpec.describe BuyerAppointment, type: :model do
  subject { build(:buyer_appointment) }

  context 'relationship' do
    before {subject.save}
    it 'with seller_appointment should not be nil' do
      subject.seller_appointment_id = nil
      expect(subject).to_not be_valid
    end

    before {subject.save}
    it 'with buyer should not be nil' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end
  end

end