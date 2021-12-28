require 'rails_helper'

RSpec.describe 'employees', type: :view do
  before(:each) do
    @organisation = create(:organisation)
    @employee = create(:employee, organisation_id: @organisation.id)
  end

  describe 'employees#index' do
    it 'displays correct view when having permissions to edit' do
      without_partial_double_verification do
        allow(view).to receive(:policy).and_return(double('some policy', update?: true))
      end
      assign(:employee, @employee)
      render template: 'employees/show.html.erb'
      expect(rendered).to include('Sang Nguyen')
      expect(rendered).to include('Avatar URL')
      expect(rendered).to include('20/12/2021')
      expect(rendered).to include('test@gmail.com')
      expect(rendered).to include('system')
      expect(rendered).to include('Edit')
      expect(rendered).to include('Back')
    end

    it 'displays correct view when dont have permissions to edit' do
      without_partial_double_verification do
        allow(view).to receive(:policy).and_return(double('some policy', update?: false))
      end
      assign(:employee, @employee)
      render template: 'employees/show.html.erb'
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
