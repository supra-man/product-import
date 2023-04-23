module Finder
  class << self
    def product_finder(params)
      if params[:code].present?
        product = Product.find_by(code: params[:code])
      else
        product = Product.find_by(id: params[:id])
      end
      return product if product.present?
      return { message: "Not Found" }
    end
  end
end
