require 'rails_helper'

RSpec.describe 'sessions/about.html.haml', type: :view do
  describe 'session#about' do
    it 'displays correct view' do
      render template: 'sign_up/about.html.erb'
      expect(rendered).to include('This is About page')
    end
  end
end
