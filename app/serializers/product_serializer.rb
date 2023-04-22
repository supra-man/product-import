class ProductSerializer < ActiveModel::Serializer
  include ActiveModel::Serializer::Pagination
  attributes :name, :code, :images

  def pagination_options
    {
      total_pages: object.total_pages,
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.prev_page,
      total_count: object.total_count,
    }
  end
end
