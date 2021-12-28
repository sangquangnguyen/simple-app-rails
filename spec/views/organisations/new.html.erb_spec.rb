require 'rails_helper'

RSpec.describe 'organisations/new.html.erb', type: :view do
  describe 'organisations#new' do
    it 'displays correct view' do
      assign(:organisation, Organisation.new)
      render template: 'organisations/new.html.erb'
      expect(rendered).to include('Creating Organisation')
      expect(rendered).to include('Name')
      expect(rendered).to include('Logo')
      expect(rendered).to include('Create Organisation')
      expect(rendered).to include('Show')
      expect(rendered).to include('Back')
    end
  end
end
