require 'rails_helper'

RSpec.describe 'organisations/edit.html.erb', type: :view do
  before(:each) do
    @organisation = create(:organisation)
  end

  describe 'organisations#edit' do
    it 'displays correct view' do
      assign(:organisation, @organisation)
      render template: 'organisations/edit.html.erb'
      expect(rendered).to include('Editing Organisation')
      expect(rendered).to include('Employment Hero')
      expect(rendered).to include('Update Organisation')
      expect(rendered).to include('Show')
      expect(rendered).to include('Back')
    end
  end
end
