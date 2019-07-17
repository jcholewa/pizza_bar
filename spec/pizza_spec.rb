require 'rails_helper'

RSpec.describe "Pizza", type: :request do
  let(:json) { JSON.parse(response.body, symbolize_names: true) }

  it "has a name" do
    expect(Pizza.new).to respond_to(:name)
  end

  it "returns http created when posting to the api" do
    post "/pizza", params: {
      pizza: {
        name: "El Pendo",
        ingredients: [
          "Parsley",
          "Pepperoni",
          "Pickle",
          "Pineapple",
          "Prawns"
        ]
      }
    }
    expect(response).to have_http_status(:created)
  end

  it "returns http unprocessable when posting to the api without a name" do
      post "/pizza", params: {
        pizza: {
          ingredients: [
            "Parsley",
            "Pepperoni",
            "Pickle",
            "Pineapple",
            "Prawns"
          ]
        }
      }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "is created when posting to the api" do
    post "/pizza", params: {
      pizza: {
        name: "El Pendo",
        ingredients: [
          "Parsley",
          "Pepperoni",
          "Pickle",
          "Pineapple",
          "Prawns"
        ]
      }
    }
    expect(Pizza.count).to eq(1)
  end

  it "returns http success when listing pizza" do
    get "/pizza"
    expect(response).to have_http_status(:success)
  end

  it "returns an empty array if there are no pizzas" do
    get "/pizza"
    expect(json).to eq([])
  end

  it "returns pizzas serialized as json" do
    post "/pizza", params: {
      pizza: {
        name: "El Pendo",
        ingredients: [
          "Parsley",
          "Pepperoni",
          "Pickle",
          "Pineapple",
          "Prawns"
        ]
      }
    }

    get "/pizza"

    expect(json).to eq([{
        id: Pizza.first.id,
        name: "El Pendo",
        ingredients: [
          "Parsley",
          "Pepperoni",
          "Pickle",
          "Pineapple",
          "Prawns"
        ]
    }])
  end

  it "returns pizzas serialized as json" do
    post "/pizza", params: {
      pizza: {
        name: "El Pendo",
        ingredients: [
          "Parsley",
          "Pepperoni",
          "Pickle",
          "Pineapple",
          "Prawns"
        ]
      }
    }

    get "/pizza/#{Pizza.first.id}"

    expect(json).to eq({
        id: Pizza.first.id,
        name: "El Pendo",
        ingredients: [
          "Parsley",
          "Pepperoni",
          "Pickle",
          "Pineapple",
          "Prawns"
        ]
    })
  end

end
