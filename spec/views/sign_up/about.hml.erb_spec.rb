require 'rails_helper'

RSpec.describe 'sign_up/about.html.erb', type: :view do
  describe 'sign_up#about' do
    it 'displays correct view' do
      render
      expect(rendered).to include('This is About page')
    end
  end
end
