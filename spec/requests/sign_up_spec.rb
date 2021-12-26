require 'rails_helper'

RSpec.describe "SignUps", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/sign_up/index"
      expect(response).to have_http_status(:success)
    end
  end

end
