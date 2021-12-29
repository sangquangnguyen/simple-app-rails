require 'rails_helper'

RSpec.describe 'sessions/about.html.erb', type: :view do
  describe 'session#about' do
    it 'displays correct view' do
      render
      expect(rendered).to include('This is About page')
    end
  end
end
