require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:organisation) { create(:organisation) }
  before(:each) do
    @employee = create(:employee, organisation_id: organisation.id)
  end

  describe 'creation' do
    it 'should have one item created after being created' do
      expect(Employee.all.count).to eq(1)
    end
  end

  describe 'validation' do
    it 'should not let a employee be created without avatar, fname, lname, birthday, role, password' do
      @employee.avatar = nil
      @employee.fname = nil
      @employee.lname = nil
      @employee.birthday = nil
      @employee.role = nil
      @employee.valid?

      expect(@employee.errors[:avatar].size).to eq(1)
      expect(@employee.errors[:fname].size).to eq(1)
      expect(@employee.errors[:lname].size).to eq(1)
      expect(@employee.errors[:birthday].size).to eq(1)
      expect(@employee.errors[:role].size).to eq(1)
    end

    it 'should not let a employee be created without email' do
      @employee.email = nil
      @employee.valid?
      expect(@employee.errors[:email].size).to eq(2)
    end

    it 'should not let a employee be created with invalid email' do
      @employee.email = 'abc'
      @employee.valid?
      expect(@employee.errors[:email].size).to eq(1)
    end

    it 'should not let a employee be created with empty password' do
      empty_password = Employee.create(avatar: 'Avatar URL', fname: 'Sang', lname: 'Nguyen', birthday: '16/05/1996',
                                       role: 'system', password: 'abc', email: 'test@gmail.com', organisation_id: organisation.id)
      expect(empty_password).to be_invalid
    end
  end

  describe 'Assosiation' do
    it 'should be belong to organisation' do
      expect(@employee).to belong_to(:organisation)
    end
  end
end
