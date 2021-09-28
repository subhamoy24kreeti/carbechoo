require 'rails_helper'

RSpec.describe KillometerDriven, type: :model do
  subject { build(:killometer_driven) }

  before {subject.save}
  context "killometer range" do
    it "should not be empty" do
      subject.killometer_range = nil
      expect(subject).to_not be_valid
    end
  end

end