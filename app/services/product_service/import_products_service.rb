module ProductService
  class ImportProductsService
    require 'csv'
    require 'open-uri'
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
      # binding.pry
      # images = "https://i.imgur.com/ZWnhY9T.png"
      # downloaded_image = URI.parse(image_url).open
      # Product.last.images.attach(io:downloaded_image,filename:"ffo.jpg")
      ActiveRecord::Base.transaction do
        csv_data.each do |row|
          product = Product.find_or_initialize_by(row.except("images"))
          row["images"].each do |image,index|
            downloaded_image = URI.parse(image).open
            product.images.attach(io:downloaded_image,filename:"#{row["code"]}-#{index}")
          end
          product.save!
        end
      end
    end
  end
end
