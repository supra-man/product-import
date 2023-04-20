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
class Product < ApplicationRecord
  has_many_attached :images, :dependent => :destroy

  validates :code, presence: true, uniqueness: true
end
