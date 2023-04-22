class Api::V1::ProductsController < ApplicationController
  require 'csv'
  before_action :set_product, only: %i[show update destroy]

  # GET /api/v1/products
  def index
    @products = Product.all

    render json: @products
  end

  # GET /api/v1/products/1
  def show
    render json: @product
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # POST /api/v1/products
  def import_products
    file = params[:csv_file]
    images = params[:images]
    csv_data = extract_csv(file)
    response = ImportProductWorker.perform_async(csv_data)
    render json: 'CSV submitted for processing.', status: :created
  end

  # PATCH/PUT /api/v1/products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/products/1
  def destroy
    @product.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:code, :name, :csv_file, :images)
  end

  def extract_csv(file)
    csv = check_csv_validity(file)
    csv_obj = []
    csv.each do |row|
      csv_obj << row
    end
    @csv_data = csv_obj.map { |row| row.to_hash }
  end

  def check_csv_validity(file)
    return json: 'File Empty' if file.blank?

    new_file = File.new(file.path)
    begin
      csv = CSV.parse(file.read, headers: true)
    rescue CSV::MalformedCSVError
      return json: 'Invalid CSV file format.'
    end
    expected_headers = %w[name code images]
    if (actual_headers - csv.headers).present?
      return "Invalid CSV file format. Expected headers: #{expected_headers.join(', ')}"
    end

    csv
  end
end
