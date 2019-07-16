require 'rails_helper'

RSpec.describe "Creating Pizza" do
  describe "POST /pizza" do
    before do
      post "/pizza", params: {
        name: "El Pendo",
        ingredients: [
          "Parsley",
          "Pepperoni",
          "Pickle",
          "Pineapple",
          "Prawns"
        ]
      }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
