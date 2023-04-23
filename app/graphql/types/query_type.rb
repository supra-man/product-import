module Types
  class QueryType < Types::BaseObject
    field :products, [Types::ProductType], null: false

    field :product, Types::ProductType, null: false do
      argument :id, ID, required: true
    end

    def product(id:)
      Product.find(id)
    end

    def products
      Product.all
    end
  end
end
