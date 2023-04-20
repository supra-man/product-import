require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:product, 10)
      get '/api/v1/products'
    end
    
    it 'returns all products' do
      expect(JSON.parse(response.body).count).to eq(10)
    end
  end
end
