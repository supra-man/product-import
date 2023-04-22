# frozen_string_literal: true

require "rails_helper"
RSpec.describe(ProductService::ImportProductsService) do
  describe "#Execute" do
    let(:payload) do
      [
        {
          "code" => "B0BDHZK",
          "name" => "Watch",
          "image" => "https://m.media-amazon.com/images/I/51Q2Xb+r+EL._AC_SL1500_.jpg",
        },
        {
          "code" => "B09G9F",
          "name" => "Laptop",
          "image" => "https://m.media-amazon.com/images/I/61GjAak00vL._AC_SL1500_.jpg",
        },
      ]
    end
    let(:payload1) do
      [
        {
          "code" => "B0BDHZK",
          "name" => "Mobile",
          "image" => "https://m.media-amazon.com/images/I/61rJppg7+lL._AC_SL1500_.jpg",
        },
      ]
    end
    subject do
      ProductService::ImportProductsService.new(payload).execute
    end

    it "Should create two product" do
      expect do
        subject
      end.to change(Product, :count).by(2)
    end

    it "Should change product name of exisiting product" do
      subject
      product = Product.find_by(code: payload[0]["code"])
      ProductService::ImportProductsService.new(payload1).execute
      product.reload
      expect(product.images.count).to eq(2)
      expect(product.name).to eq(payload1[0]["name"])
    end

    it "Should not attach an image if the url is invalid" do
      subject
      payload1[0]["image"] = "failedtestexample"
      ProductService::ImportProductsService.new(payload1).execute
      product = Product.find_by(code: payload[0]["code"])
      expect(product.images.count).to eq(1)
    end
  end
end
