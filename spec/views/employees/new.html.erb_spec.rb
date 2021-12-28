require 'rails_helper'

RSpec.describe 'employees/new.html.erb', type: :view do
  before(:each) do
    @organisation = create(:organisation)
  end

  describe 'employees#new' do
    it 'displays correct view when having permissions to edit' do
      assign(:employee, @organisation.employees.build)
      assign(:roles, Employee.roles.map { |key, value| [key, value] })
      render
      expect(rendered).to include('Fname')
      expect(rendered).to include('Lname')
      expect(rendered).to include('Avatar')
      expect(rendered).to include('Birthday')
      expect(rendered).to include('Email')
      expect(rendered).to include('Create Employee')
      expect(rendered).to include('Show')
      expect(rendered).to include('Back')
    end
  end
end
