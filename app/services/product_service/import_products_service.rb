# frozen_string_literal: true

module ProductService
  class ImportProductsService
    require 'csv'
    require 'base64'
    require 'open-uri'
    attr_accessor :csv_data, :failed_products

    def initialize(csv_data)
      @csv_data = csv_data
      @failed_products = []
    end

    def execute
      response = create_products
    end

    private

    def create_products
      puts 'Starting Product Import'
      csv_data.each do |row|
        product = Product.find_or_initialize_by(code: row['code'])
        product.name = row['name']
        downloaded_image = URI.parse(row['image']).open
        product_images = product.images.map { |image| image.filename.to_s }
        downloaded_image_filename = Base64.strict_encode64(row['image'])
        unless product_images.include?(downloaded_image_filename)
          product.images.attach(io: downloaded_image, filename: downloaded_image_filename)
        end
        product.save!
      rescue StandardError
        puts "Failed for product row : #{row}"
      end
      puts 'Product Import Completed..'
    end
  end
end
