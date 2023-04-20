require 'test_helper'

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_product = api_v1_products(:one)
  end

  test 'should get index' do
    get api_v1_products_url, as: :json
    assert_response :success
  end

  test 'should create api_v1_product' do
    assert_difference('Api::V1::Product.count') do
      post api_v1_products_url, params: { api_v1_product: {} }, as: :json
    end

    assert_response :created
  end

  test 'should show api_v1_product' do
    get api_v1_product_url(@api_v1_product), as: :json
    assert_response :success
  end

  test 'should update api_v1_product' do
    patch api_v1_product_url(@api_v1_product), params: { api_v1_product: {} }, as: :json
    assert_response :success
  end

  test 'should destroy api_v1_product' do
    assert_difference('Api::V1::Product.count', -1) do
      delete api_v1_product_url(@api_v1_product), as: :json
    end

    assert_response :no_content
  end
end
