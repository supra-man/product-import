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
          images = product.images.map { |image| rails_blob_url(image, only_path: true) }
          { code: product.code, name: product.name, images: images }
        end
        render json: { products: products, meta: pagination_params(Product.page(page).per(size)) }
      end

      def show
        product = Product.find(params[:id])
        images = product.images.map { |image| rails_blob_url(image, only_path: true) }

        render json: { product: product, images: images }
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
        product.images.purge # deletes all associated images
        product.destroy # deletes the product
        render json: { message: "Product deleted successfully" }
      end

      private

      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:code, :name, :csv_file, :images)
      end

      def extract_csv(file)
        csv = check_csv_validity(file)
        if csv[:valid]
          csv_obj = []
          csv[:csv_data].each do |row|
            csv_obj << row
          end
          csv_data = csv_obj.map(&:to_hash)
        else
          return csv
        end
        return { valid: true, csv_data: csv_data }
      end

      def check_csv_validity(file)
        return { valid: false, message: "File Empty" } if file.blank?

        new_file = File.new(file.path)
        begin
          csv = CSV.parse(file.read, headers: true)
        rescue CSV::MalformedCSVError
          return { valid: false, message: "Invalid CSV file format." }
        end
        expected_headers = %w[name code image]
        if (expected_headers - csv.headers).present?
          return { valid: false, message: "Invalid CSV file format. Expected headers: #{expected_headers.join(", ")}" }
        end

        { valid: true, csv_data: csv }
      end

      def default_page_size
        Kaminari.config.default_per_page
      end

      # def pagination_params(obj)
      #   {
      #     current_page: obj.current_page,
      #     next_page: obj.next_page,
      #     prev_page: obj.prev_page,
      #     total_pages: obj.total_pages,
      #     total_count: obj.total_count,
      #   }
      # end
    end
  end
end
