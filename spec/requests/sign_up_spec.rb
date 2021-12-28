require 'rails_helper'

RSpec.describe 'SignUps', type: :request do
  let(:organisation) { create(:organisation) }

  describe 'GET /sign_up' do
    it 'returns http success' do
      get '/sign_up'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Signup')
    end
  end

  describe 'POST /sign_up' do
    it 'should redirect to login page when sign up successfully' do
      employee = attributes_for(:employee, organisation_id: organisation.id)
      post '/sign_up', params: { employee: employee }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(login_path)
      follow_redirect!
    end

    it 'should show errors when params is invalid' do
      employee = attributes_for(:employee, organisation_id: organisation.id, email: nil, fname: nil)
      post '/sign_up', params: { employee: employee }
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Fname can&#39;t be blank')
      expect(response.body).to include('Email can&#39;t be blank')
      expect(response.body).to include('Email Invalid email')
    end
  end

  describe 'GET /verify_account' do
    it 'should function correctly' do
      employee = create(:employee, organisation_id: organisation.id, verified: false)
      get verify_account_path(employee.id)
      expect(response).to have_http_status(:found)
      queryEmployee = Employee.find(employee.id)
      expect(queryEmployee.verified).to be true
    end
  end

  describe 'GET /about' do
    it 'returns http success' do
      get '/about'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('This is About page')
    end
  end
end
