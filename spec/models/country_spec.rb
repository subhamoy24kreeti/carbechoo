require 'rails_helper'

RSpec.describe Country, type: :model do
  subject { build(:country) }

  before {subject.save}
  context 'country name' do
    it 'should not be nil' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should not be empty' do
      subject.name = ''
      expect(subject).to_not be_valid
    end

  end
end