# frozen_string_literal: true

module ProductService
  class ImportProductsService
    require "csv"
    require "open-uri"
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
      csv_data.each do |row|
        product = Product.find_or_initialize_by(code: row["code"])
        product.name = row["name"]
        downloaded_image = URI.parse(row["image"]).open

        product.images.attach(io: downloaded_image, filename: File.basename(downloaded_image))
        product.save!
      rescue StandardError
        puts "Failed for product row : #{row}"
      end
    end
  end
end
