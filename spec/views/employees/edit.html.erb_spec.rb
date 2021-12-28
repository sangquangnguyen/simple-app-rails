require 'rails_helper'

RSpec.describe 'employees/edit.html.erb', type: :view do
  before(:each) do
    @organisation = create(:organisation)
    @employee = create(:employee, organisation_id: @organisation.id)
  end

  describe 'employees#edit' do
    it 'displays correct view when having permissions to edit' do
      assign(:employee, @employee)
      assign(:roles, Employee.roles.map { |key, value| [key, value] })
      render
      expect(rendered).to include('Fname')
      expect(rendered).to include('Sang')
      expect(rendered).to include('Lname')
      expect(rendered).to include('Nguyen')
      expect(rendered).to include('Avatar')
      expect(rendered).to include('Avatar URL')
      expect(rendered).to include('Birthday')
      expect(rendered).to include('2021-12-20')
      expect(rendered).to include('Email')
      expect(rendered).to include('test@gmail.com')
      expect(rendered).to include('Update Employee')
      expect(rendered).to include('Show')
      expect(rendered).to include('Back')
    end
  end
end
