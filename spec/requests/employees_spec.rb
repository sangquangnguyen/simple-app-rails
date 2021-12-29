require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  let(:organisation) { create(:organisation) }
  let(:password) { '123456' }
  before(:each) do
    @employee = create(:employee, organisation_id: organisation.id, verified: true, password: password)
  end

  describe 'GET /employees/:id' do
    describe 'when user is anonymous' do
      it 'redirects user to root path' do
        get organisation_employee_path(organisation, @employee)
        expect(response).to redirect_to login_path
      end
    end

    describe 'when user is logged' do
      before(:each) do
        sign_in(@employee.email, password)
      end

      it 'shows all activities for signed in user' do
        get organisation_employee_path(organisation, @employee)
        expect(response).to have_http_status(:success)
        expect(response.body).to include('Name')
        expect(response.body).to include('Sang Nguyen')
      end
    end
  end

  describe 'POST /employees/:id' do
    before(:each) do
      sign_in(@employee.email, password)
    end

    it 'should function correctly' do
      employee_created = attributes_for(:employee, email: 'employmenthero2@gmail.com')
      post organisation_employees_path(organisation, @employee),
           params: { employee: employee_created }
      expect(response).to redirect_to organisation_employee_path(organisation, @employee.id + 1)
    end

    it 'should display error when having invalid params' do
      employee_created = attributes_for(:employee, email: nil)
      post organisation_employees_path(organisation, @employee),
           params: { employee: employee_created }
      expect(response.body).to include('Email can&#39;t be blank')
    end
  end

  describe 'PUT /organisations' do
    before(:each) do
      sign_in(@employee.email, password)
    end

    it 'should function correctly' do
      employee_updated = attributes_for(:employee, lname: 'Sangg')
      put organisation_employee_path(organisation, @employee),
          params: { employee: employee_updated }
      expect(response).to redirect_to organisation_employee_path(organisation, @employee)
    end

    it 'should display error when having invalid params' do
      employee_updated = attributes_for(:employee, lname: nil)
      put organisation_employee_path(organisation, @employee),
          params: { employee: employee_updated }
      expect(response.body).to include('Lname can&#39;t be blank')
    end
  end
end
