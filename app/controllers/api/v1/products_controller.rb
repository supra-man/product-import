class Api::V1::ProductsController < ApplicationController
  before_action :set_api_v1_product, only: %i[ show update destroy ]

  # GET /api/v1/products
  def index
    @api_v1_products = Api::V1::Product.all

    render json: @api_v1_products
  end

  # GET /api/v1/products/1
  def show
    render json: @api_v1_product
  end

  # POST /api/v1/products
  def create
    @api_v1_product = Api::V1::Product.new(api_v1_product_params)

    if @api_v1_product.save
      render json: @api_v1_product, status: :created, location: @api_v1_product
    else
      render json: @api_v1_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/products/1
  def update
    if @api_v1_product.update(api_v1_product_params)
      render json: @api_v1_product
    else
      render json: @api_v1_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/products/1
  def destroy
    @api_v1_product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_product
      @api_v1_product = Api::V1::Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_product_params
      params.fetch(:api_v1_product, {})
    end
end
