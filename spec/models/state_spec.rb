require 'rails_helper'

RSpec.describe State, type: :model do
  subject { build(:state) }
  before {subject.save}
  it 'state should be saved successfully' do
    expect(subject).to be_valid
  end

  before {subject.save}
  it 'country should be present' do
    subject.country_id = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'state name should be nil' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'state name should not be empty' do
    subject.name = ''
    expect(subject).to_not be_valid
  end

end