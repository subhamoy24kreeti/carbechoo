require 'rails_helper'

RSpec.describe Brand, type: :model do
  subject { build(:brand) }

  context "brand_name" do
    before {subject.save}
    it "should not be nil" do
      subject.brand_name = nil
      expect(subject).to_not be_valid
    end
    before {subject.save}
    it "should not be empty" do
      subject.brand_name = ''
      expect(subject).to_not be_valid
    end
  end
end