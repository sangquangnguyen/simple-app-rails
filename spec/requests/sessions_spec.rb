require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:organisation) { create(:organisation) }
  before(:each) do
    @employee = create(:employee, organisation_id: organisation.id, verified: true)
  end

  describe 'GET /login' do
    it 'returns http success' do
      get '/login'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /login' do
    it 'should login success with valid email and password' do
      post '/login', params: { session: { email: 'test@gmail.com', password: 'abc' } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to root_path
      follow_redirect!
      expect(response.body).to include('Logged in successfully')
    end

    it 'should show error with invalid email or password' do
      post '/login', params: { session: { email: 'test@gmail.com', password: 'abcd' } }
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Invalid email or password')
    end

    it 'should show error when the account is not verified' do
      @employee.verified = false
      @employee.save
      post '/login', params: { session: { email: 'test@gmail.com', password: 'abc' } }
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Account has not been verified yet')
    end
  end
end
