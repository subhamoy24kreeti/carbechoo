require 'rails_helper'

RSpec.describe CostRange, type: :model do
  subject { build(:cost_range) }

  before {subject.save}
  it 'cost range -> quality should not be nil' do
    subject.quality = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'cost range -> quality should not be nil' do
    subject.quality = ''
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'range1 should not be nil' do
    subject.range1 = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'range1 should not be empty' do
    subject.range1 = ''
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'range2 should not be nil' do
    subject.range2 = nil
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'range2 should not be empty' do
    subject.range2 = ''
    expect(subject).to_not be_valid
  end

  before {subject.save}
  it 'range2 should be greater than range1' do
    subject.range1 = 54848
    subject.range2 = 45544
    expect(subject).to_not be_valid
  end

end