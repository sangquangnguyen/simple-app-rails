require 'rails_helper'

RSpec.describe 'sessions/new.html.haml', type: :view do
  describe 'session#new' do
    it 'displays correct view' do
      render template: 'sessions/new.html.erb'
      expect(rendered).to include('Login')
      expect(rendered).to include('Email')
      expect(rendered).to include('Password')
      expect(rendered).to include('Register')
      expect(rendered).to include('Login')
    end
  end
end
