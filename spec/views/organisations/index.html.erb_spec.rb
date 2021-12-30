require 'rails_helper'

RSpec.describe 'organisations/index.html.erb', type: :view do
  include Pundit

  before(:each) do
    @organisation = create(:organisation)
    @employee = create(:employee, organisation_id: @organisation.id)
  end

  describe 'organisations#index' do
    it 'displays correct view when having permissions to show, edit and delete' do
      allow(view).to receive(:policy).and_return(double('some policy', show?: true, update?: true, destroy?: true,
                                                                       create?: true))
      organisations = Organisation.all
      assign(:organisations, organisations)
      render
      expect(rendered).to include('Organisations')
      expect(rendered).to include('Name')
      expect(rendered).to include('Logo')
      expect(rendered).to include('Actions')
      expect(rendered).to include('Employment Hero')
      expect(rendered).to include('Edit')
      expect(rendered).to include('Destroy')
      expect(rendered).to include('New Organisation')
    end

    it 'displays correct view when do not have permissions to show, edit and delete' do
      allow(view).to receive(:policy).and_return(double('some policy', show?: false, update?: false, destroy?: false,
                                                                       create?: false))
      organisations = Organisation.all
      assign(:organisations, organisations)
      render
      expect(rendered).to include('Organisations')
      expect(rendered).to include('Name')
      expect(rendered).to include('Logo')
      expect(rendered).to include('Actions')
      expect(rendered).not_to include('Employment Hero')
      expect(rendered).not_to include('Edit')
      expect(rendered).not_to include('Destroy')
      expect(rendered).not_to include('New Organisation')
    end
  end
end
