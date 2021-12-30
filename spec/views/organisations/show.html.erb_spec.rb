require 'rails_helper'

RSpec.describe 'organisations/index.html.erb', type: :view do
  include Pundit

  before(:each) do
    @organisation = create(:organisation)
    @employee = create(:employee, organisation_id: @organisation.id)
  end

  describe 'organisations#show' do
    it 'displays correct view when having permissions to show, edit and delete' do
      allow(view).to receive(:policy).and_return(double('some policy', show?: true, update?: true, destroy?: true,
                                                                       create?: true))
      assign(:organisations, Organisation.all)
      render
      expect(rendered).to include('Organisations')
      expect(rendered).to include('Employment Hero')
      expect(rendered).to include('Show')
      expect(rendered).to include('Edit')
      expect(rendered).to include('Destroy')
      expect(rendered).to include('New Organisation')
    end

    it 'displays correct view when do not have permissions to show, edit and delete' do
      allow(view).to receive(:policy).and_return(double('some policy', show?: false, update?: false, destroy?: false,
                                                                       create?: false))
      assign(:organisations, Organisation.all)
      render
      expect(rendered).to include('Organisations')
      expect(rendered).not_to include('Employment Hero')
      expect(rendered).not_to include('Show')
      expect(rendered).not_to include('Edit')
      expect(rendered).not_to include('Destroy')
      expect(rendered).not_to include('New Organisation')
    end
  end
end
