require 'rails_helper'

RSpec.describe Organisation, type: :model do
  before(:each) do
    @organisation = create(:organisation)
  end

  describe 'creation' do
    it 'should have one item created after being created' do
      expect(Organisation.all.count).to eq(1)
    end
  end

  describe 'validation' do
    it 'should not let a organisation be created without name' do
      @organisation.name = nil
      @organisation.valid?

      expect(@organisation.errors[:name].size).to eq(1)
    end

    it 'should not let a organisation be created without logo' do
      @organisation.logo = nil
      @organisation.valid?

      expect(@organisation.errors[:logo].size).to eq(1)
    end
  end

  describe 'Assosiation' do
    it { should have_many(:employees) }
  end
end
