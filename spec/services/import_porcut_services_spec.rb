# frozen_string_literal: true

require 'rails_helper'
RSpec.describe(ProductService::ImportProductsService) do
  describe '#Execute' do
    let(:payload) do
      [
        {
          'code' => 'B0BDHZK',
          'name' => 'Watch',
          'image' => 'https://m.media-amazon.com/images/I/51Q2Xb+r+EL._AC_SL1500_.jpg'
        },
        {
          'code' => 'B09G9F',
          'name' => 'Laptop',
          'image' => 'https://m.media-amazon.com/images/I/61GjAak00vL._AC_SL1500_.jpg'
        }
      ]
    end
    subject do
      ProductService::ImportProductsService.new(payload).execute
    end

    it 'Should create two product' do
      expect do
        subject
      end.to change(Product, :count).by(2)
    end
  end
end
