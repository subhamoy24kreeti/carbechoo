require 'rails_helper'

RSpec.describe City, type: :model do
  subject { build(:city) }

  before {subject.save}
  it 'state should  not be present' do
    subject.state_id = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'city should be saved successfully' do
    expect(subject).to be_valid
  end

  before {subject.save}
  it 'city name should be nil' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'city name should not be empty' do
    subject.name = ''
    expect(subject).to_not be_valid
  end

end