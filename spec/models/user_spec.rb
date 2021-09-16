require 'rails_helper'

RSpec.describe User, type: :model do
    subject { User.new(first_name: "subhamoy", last_name: 'das', email: 'subuamoydas24@gmail.com', password: 'passpass', password_confirmation: 'passpass',city: 'kharagpur', state: 'west bengal', country:'india', zip_code:'721305',role: 'seller' )}
    
    """before {subject.save}
    it 'first_name must be present' do
        subject.first_name = ''
        expect(subject).to_not be_valid
    end

    before {subject.save}
    it 'last_name must be present' do
        subject.last_name = ''
        expect(subject).to_not be_valid
    end

    before {subject.save}
    it 'password must be present' do
        #u = User.new(first_name: 'subhamoy', last_name: 'das', email: 'subuamoydas24@gmail.com', password: 'passpass', password_confirmation: 'passpass',city: 'kharagpur', state: 'west bengal', country:'india', zip_code:'721305',role: 'seller' )
        subject.password = ''
        subject.password_confirmation = ''
        expect(subject).to_not  be_valid
    end

    before {subject.save}
    it 'confirmation must be present' do
        subject.password_confirmation = ''
        expect(subject).to_not  be_valid
    end

    before {subject.save}
    it 'password and confirmation password must be equal' do
        subject.password_confirmation = 'ppp'
        expect(subject).to_not be_valid
    end

    before {subject.save}
    it 'phone number length should not less than 10' do
        subject.phone = '988975'
        expect(subject).to_not be_valid
    end

    before {subject.save}
    it 'phone number length  is 10' do
        subject.phone = '9889758985'
        expect(subject).to be_valid
    end

    before {subject.save}
    it 'phone number should not greater 10' do
        subject.phone = '9889758879797977989799989'
        expect(subject).to_not be_valid
    end

    before {subject.save}
    it 'phone number numerality not greater 10' do
        subject.phone = '988gdhyuo9'
        expect(subject).to_not be_valid
    end"""
    before {subject.save}
    it 'email must be present' do
        subject.email = 'hfhhdh'
        expect(subject).to_not be_valid
    end
end