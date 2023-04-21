require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  let(:product1) { create(:product) }

  describe 'GET /products' do
    before do
      FactoryBot.create_list(:product, 10)
      get '/api/v1/products'
    end

    it 'returns all products' do
      expect(JSON.parse(response.body).count).to eq(10)
    end

    it 'should return error on duplicate code' do
      expect do
        FactoryBot.create(:product, code: Product.first.code)
      end.to raise_error(ActiveRecord::RecordInvalid)
      expect(JSON.parse(response.body).count).to eq(10)
    end
  end

  describe 'GET /products/:id' do
    let(:product) { create(:product) }
    before do
      FactoryBot.create_list(:product, 10)
      get "/api/v1/products/#{product.id}"
    end

    it 'returns a product' do
      res = JSON.parse(response.body)
      expect(res['id']).to eq(product.id)
      expect(res['code']).to eq(product.code)
    end
  end

  describe 'DELETE /product/:id' do
    before do
      FactoryBot.create_list(:product, 10)
    end
    it 'returns a product' do
      expect do
        delete "/api/v1/products/#{Product.first.id}"
      end.to change(Product, :count).by(-1)
    end
  end
end
