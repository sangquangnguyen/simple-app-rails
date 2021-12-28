require 'rails_helper'

RSpec.describe 'organisations', type: :view do
  before(:each) do
    @organisation = create(:organisation)
    @employee = create(:employee, organisation_id: @organisation.id)
  end

  describe 'organisations#index' do
    it 'displays correct view when having permissions to show, edit and delete' do
      without_partial_double_verification do
        allow(view).to receive(:policy).and_return(double('some policy', show?: true, update?: true, destroy?: true,
                                                                         create?: true))
      end
      organisations = Organisation.all
      assign(:organisations, organisations)
      render template: 'organisations/index.html.erb'
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
      without_partial_double_verification do
        allow(view).to receive(:policy).and_return(double('some policy', show?: false, update?: false, destroy?: false,
                                                                         create?: false))
      end
      organisations = Organisation.all
      assign(:organisations, organisations)
      render template: 'organisations/index.html.erb'
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

  describe 'organisations#show' do
    it 'displays correct view when having permissions to show, edit and delete' do
      without_partial_double_verification do
        allow(view).to receive(:policy).and_return(double('some policy', show?: true, update?: true, destroy?: true,
                                                                         create?: true))
      end
      assign(:organisation, @organisation)
      render template: 'organisations/show.html.erb'
      expect(rendered).to include('Employment Hero')
      expect(rendered).to include('Employees')
      expect(rendered).to include('Sang Nguyen')
      expect(rendered).to include('test@gmail.com')
      expect(rendered).to include('Show')
      expect(rendered).to include('Edit')
      expect(rendered).to include('Destroy')
      expect(rendered).to include('New Employee')
    end

    it 'displays correct view when do not have permissions to show, edit and delete' do
      without_partial_double_verification do
        allow(view).to receive(:policy).and_return(double('some policy', show?: false, update?: false, destroy?: false,
                                                                         create?: false))
      end
      assign(:organisation, @organisation)
      render template: 'organisations/show.html.erb'
      expect(rendered).to include('Employment Hero')
      expect(rendered).to include('Employees')
      expect(rendered).not_to include('Sang Nguyen')
      expect(rendered).not_to include('test@gmail.com')
      expect(rendered).not_to include('Show')
      expect(rendered).not_to include('Edit')
      expect(rendered).not_to include('Destroy')
      expect(rendered).not_to include('New Employee')
    end
  end
end