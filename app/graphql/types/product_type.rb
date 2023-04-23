# app/graphql/types/product_type.rb

module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :code, String, null: false
    field :images, [Types::ImageType], null: true

    def images
      object.images.map do |image|
        {
          id: image.id,
          filename: image.blob.filename,
          url: Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true),
        }
      end
    end
  end
end
