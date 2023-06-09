module Types
  class ImageType < Types::BaseObject
    field :id, ID, null: false
    field :filename, String, null: false
    field :url, String, null: false
  end
end
