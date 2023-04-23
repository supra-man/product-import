# frozen_string_literal: true

require "rails_helper"
require "active_job/test_helper"

RSpec.describe "Api::V1::Products", type: :request do
  let(:product1) { create(:product) }

  describe "GET /products" do
    before do
      FactoryBot.create_list(:product, 10)
      get "/api/v1/products"
    end

    it "returns all products" do
      expect(JSON.parse(response.body)["products"].count).to eq(10)
    end

    it "should return error on duplicate code" do
      expect do
        FactoryBot.create(:product, code: Product.first.code)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "GET /products/:id" do
    let(:product) { create(:product) }
    before do
      FactoryBot.create_list(:product, 10)
      get "/api/v1/products/#{product.id}"
    end

    it "returns a product" do
      res = JSON.parse(response.body)
      expect(res["product"]["id"]).to eq(product.id)
      expect(res["product"]["code"]).to eq(product.code)
    end
  end

  describe "GET /products/get_product" do
    let(:product) { create(:product) }
    before do
      FactoryBot.create_list(:product, 10)
      get "/api/v1/products/get_product/?code=#{product.code}"
    end

    it "returns a product" do
      res = JSON.parse(response.body)
      expect(res["product"]["id"]).to eq(product.id)
      expect(res["product"]["code"]).to eq(product.code)
    end

    it "returns product not found message" do
      get "/api/v1/products/get_product/?code=notFound"
      res = JSON.parse(response.body)
      expect(res["message"]).to eq("Product not found")
    end
  end

  describe "DELETE /product/:id" do
    before do
      FactoryBot.create_list(:product, 10)
    end
    it "returns a product" do
      expect do
        delete "/api/v1/products/#{Product.first.id}"
      end.to change(Product, :count).by(-1)
    end
  end

  describe "DELETE /product/delete_product" do
    before do
      FactoryBot.create_list(:product, 10)
    end
    it "returns a product" do
      expect do
        delete "/api/v1/products/delete_product/?code=#{Product.first.code}"
      end.to change(Product, :count).by(-1)
    end
  end

  describe "Check CSV Valid" do
    let(:file_path) { "./spec/fixtures/product.csv" }
    it "Should save product" do
      post "/api/v1/products/import", params: { csv_file: Rack::Test::UploadedFile.new(file_path) }
      expect(response.body).to eq("CSV submitted for processing.")
    end
  end

  describe "Check invalid csv" do
    let(:file_path) { "./spec/fixtures/missingheader.csv" }
    it "Should raise error when header missing" do
      post "/api/v1/products/import", params: { csv_file: Rack::Test::UploadedFile.new(file_path) }
      expect(response.body).to eq("Invalid CSV file format. Expected headers: name, code, image")
    end
  end

  describe "Describe check csv validity" do
    before do
      FactoryBot.create_list(:product, 10)
    end
    it "returns a product" do
      expect do
        delete "/api/v1/products/#{Product.first.id}"
      end.to change(Product, :count).by(-1)
    end
  end
end
