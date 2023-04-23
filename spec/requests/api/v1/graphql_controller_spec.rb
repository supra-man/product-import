require "rails_helper"

RSpec.describe "product query", type: :request do
  let!(:product) { create(:product) }

  describe "product" do
    let(:query) do
      <<~GQL
        query {
          product(id:#{product.id}) {
            id
            name
            code
            images {
              url
            }
          }
        }
        
      GQL
    end

    it "returns a product with the correct data" do
      post "/api/v1/graphql", params: { query: query }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      data = json_response["data"]["product"]

      expect(data).to include(
        "id" => product.id.to_s,
        "code" => product.code,
        "name" => product.name,
      )
    end
  end

  describe "products" do
    let(:query) do
      <<~GQL
        query {
          products {
            id
            name
            code
            images {
              url
            }
          }
        }
        
      GQL
    end

    it "returns all products" do
      FactoryBot.create_list(:product, 10)
      post "/api/v1/graphql", params: { query: query }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      data = json_response["data"]["products"]
      expect(data.count).to eq(11)
    end
  end
end
