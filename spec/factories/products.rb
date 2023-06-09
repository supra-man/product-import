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
FactoryBot.define do
  factory :product do
    sequence(:code) { |n| "BOK-#{n}-#{SecureRandom.hex(2)}" }
    name { Faker::Lorem.word }
  end
end
