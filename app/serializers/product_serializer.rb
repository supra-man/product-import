# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                                                              :bigint           not null, primary key
#  #<ActiveRecord::ConnectionAdapters::PostgreSQL::TableDefinition :string
#  code                                                            :string           not null
#  name                                                            :string
#  created_at                                                      :datetime         not null
#  updated_at                                                      :datetime         not null
#
# Indexes
#
#  index_products_on_code  (code) UNIQUE
#
class ProductSerializer < ActiveModel::Serializer
  include ActiveModel::Serializer::Pagination
  attributes :name, :code, :images

  def pagination_options
    {
      total_pages: object.total_pages,
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.prev_page,
      total_count: object.total_count
    }
  end
end
