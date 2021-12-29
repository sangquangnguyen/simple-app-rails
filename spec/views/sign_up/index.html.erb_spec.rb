require 'rails_helper'

RSpec.describe 'sign_up/index.html.erb', type: :view do
  before(:each) do
    @organisation = create(:organisation)
  end

  describe 'session#index' do
    it 'displays correct view' do
      organisations = Organisation.all.map { |organisation| [organisation.name, organisation.id] }
      assign(:employee, Employee.new)
      assign(:organisations, organisations)
      render
      expect(rendered).to include('Signup')
      expect(rendered).to include('First Name')
      expect(rendered).to include('Last Name')
      expect(rendered).to include('Birthday')
      expect(rendered).to include('Employment Hero')
    end
  end
end
