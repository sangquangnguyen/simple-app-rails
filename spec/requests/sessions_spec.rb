require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:organisation) { Organisation.create!(name: 'Employment Hero', logo: 'This is a logo URL') }
  before(:each) do
    @employee = Employee.create!(avatar: 'Avatar URL', fname: 'Sang', lname: 'Nguyen', birthday: '16/05/1996',
                                 role: 'system', password: 'abc', email: 'test@gmail.com', organisation_id: organisation.id, verified: true)
  end

  describe 'login' do
    it 'returns http success' do
      get '/login'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /login' do
    it 'should login success with valid email and password' do
      post '/login', params: { session: { email: 'test@gmail.com', password: 'abc' } }
      expect(response).to have_http_status(:found)
      follow_redirect!
      response.body.should include('Logged in successfully')
    end

    it 'should show error with invalid email or password' do
      post '/login', params: { session: { email: 'test@gmail.com', password: 'abcd' } }
      expect(response).to have_http_status(:success)
      response.body.should include('Invalid email or password')
    end

    it 'should show error when the account is not verified' do
      @employee.verified = false
      @employee.save
      post '/login', params: { session: { email: 'test@gmail.com', password: 'abc' } }
      expect(response).to have_http_status(:success)
      response.body.should include('Account has not been verified yet')
    end
  end
end
