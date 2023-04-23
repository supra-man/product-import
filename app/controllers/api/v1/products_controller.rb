# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      include ApplicationHelper
      require "csv"
      before_action :set_product, only: %i[show update destroy]

      def index
        page = params[:page].blank? ? 1 : params[:page]
        size = params[:size].blank? ? default_page_size : params[:size]
        products = Product.page(page).per(size).map do |product|
          images = product.images.map do |image|
            { filename: image.filename, url: rails_blob_url(image, only_path: true) }
          end
          { code: product.code, name: product.name, images: images }
        end
        render json: { products: products, meta: pagination_params(Product.page(page).per(size)) }
      end

      def show
        product = Product.find(params[:id])
        images = product.images.map do |image|
          { filename: image.filename, url: rails_blob_url(image, only_path: true) }
        end

        render json: { product: product, images: images }
      end

      def get_product
        product = Finder.product_finder(params)
        if product[:message] == "Not Found"
          render json: { message: "Product not found" }
        else
          images = product.images.map do |image|
            { filename: image.filename, url: rails_blob_url(image, only_path: true) }
          end
          render json: { product: product, images: images }
        end
      end

      def import_products
        file = params[:csv_file]
        csv_data = extract_csv(file)
        if csv_data[:valid]
          response = ImportProductWorker.perform_async(csv_data[:csv_data])
          render json: "CSV submitted for processing.", status: :created
        else
          render json: csv_data[:message]
        end
      end

      def destroy
        product = Product.find(params[:id])
        product.images.purge
        product.destroy
        render json: { message: "Product deleted successfully" }
      end

      def delete
        product = Finder.product_finder(params)
        if product[:message] == "Not Found"
          render json: { message: "Product not found" }
        else
          product.images.purge
          product.destroy
          render json: { message: "Product deleted successfully" }
        end
      end

      private

      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:code, :name, :csv_file, :images)
      end
    end
  end
end
