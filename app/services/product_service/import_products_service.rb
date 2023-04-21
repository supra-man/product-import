module ProductService
  class ImportProductsService
    require 'csv'
    attr_accessor :csv_file, :file, :csv_data, :images

    def initialize(csv_file)
      @file = csv_file
    end

    def execute
      extract_csv
      create_products
    end

    private

    def extract_csv
      new_file = File.new(file.path)
      csv = CSV.parse(file.read, headers: true)
      csv_obj = []
      csv.each do |row|
        csv_obj << row
      end
      @csv_data = csv_obj.map {|row| row.to_hash}
    end

    def create_products
      # ActiveStorage::Current.host = "http://localhost:3000"
      ActiveRecord::Base.transaction do
        csv_data.each do |row|
          product = Product.find_or_initialize_by(row)
          product.images.attach(row.images)
        end
      end
      puts url_for(Product.first.images.first)
    end
  end
end
