require 'rails_helper'

RSpec.describe 'employees/show.html.erb', type: :view do
  include Pundit

  before(:each) do
    @organisation = create(:organisation)
    @employee = create(:employee, organisation_id: @organisation.id)
  end

  describe 'employees#index' do
    it 'displays correct view when having permissions to edit' do
      allow(view).to receive(:policy).and_return(double('some policy', update?: true))
      assign(:employee, @employee)
      render
      expect(rendered).to include('Sang Nguyen')
      expect(rendered).to include('Avatar URL')
      expect(rendered).to include('20/12/2021')
      expect(rendered).to include('test@gmail.com')
      expect(rendered).to include('system')
      expect(rendered).to include('Edit')
      expect(rendered).to include('Back')
    end

    it 'displays correct view when dont have permissions to edit' do
      allow(view).to receive(:policy).and_return(double('some policy', update?: false))
      assign(:employee, @employee)
      render
      expect(rendered).to include('Sang Nguyen')
      expect(rendered).to include('Avatar URL')
      expect(rendered).to include('20/12/2021')
      expect(rendered).to include('test@gmail.com')
      expect(rendered).to include('system')
      expect(rendered).not_to include('Edit')
      expect(rendered).to include('Back')
    end
  end
end
