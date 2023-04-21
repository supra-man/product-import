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
FactoryBot.define do
  factory :product do
    code { Faker::Number.number(digits: 3) }
    name { Faker::Lorem.word }
  end
end
