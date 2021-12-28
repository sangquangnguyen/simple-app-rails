require 'rails_helper'

RSpec.describe 'Organisations', type: :request do
  let(:organisation) { create(:organisation) }
  before(:each) do
    @employee = create(:employee, organisation_id: organisation.id)
  end

  describe 'GET /organisations' do
    describe 'when user is anonymous' do
      it 'redirects user to root path' do
        get '/organisations'
        expect(response).to redirect_to login_path
      end
    end

    describe 'when user is logged' do
      before(:each) do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { user_id: @employee.id } }
      end

      it 'shows all activities for signed in user' do
        get '/organisations'
        expect(response).to have_http_status(:success)
        expect(response.body).to include('Organisations')
        expect(response.body).to include('Employment Hero')
      end
    end
  end

  describe 'POST /organisations' do
    before(:each) do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { user_id: @employee.id } }
    end

    it 'should function correctly' do
      organisation_created = attributes_for(:organisation, name: 'Employment Hero 2', logo: 'This is logo 2')
      post '/organisations',
           params: { organisation: organisation_created }
      expect(response).to redirect_to organisation_path(organisation.id + 1)
    end

    it 'should display error when having invalid params' do
      organisation_created = attributes_for(:organisation, name: 'Employment Hero 2', logo: nil)
      post '/organisations',
           params: { organisation: organisation_created }
      expect(response.body).to include(`Logo can't be blank`)
    end
  end

  describe 'PUT /organisations' do
    before(:each) do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { user_id: @employee.id } }
    end

    it 'should function correctly' do
      organisation_updated = attributes_for(:organisation, name: 'Employment Hero 2', logo: 'This is logo 2')
      put organisation_path(organisation.id),
          params: { organisation: organisation_updated }
      expect(response).to redirect_to organisation_path(organisation.id)
    end

    it 'should display error when having invalid params' do
      organisation_updated = attributes_for(:organisation, name: 'Employment Hero 2', logo: nil)
      put organisation_path(organisation.id),
          params: { organisation: organisation_updated }
      expect(response.body).to include('Logo can&#39;t be blank')
    end
  end

  describe 'DELETE /organisations' do
    before(:each) do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { user_id: @employee.id } }
    end

    it 'should function correctly' do
      delete organisation_path(organisation.id)
      expect(response).to redirect_to organisations_path
    end
  end
end
