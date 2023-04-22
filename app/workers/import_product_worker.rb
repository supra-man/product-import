# frozen_string_literal: true

class ImportProductWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(csv_data)
    ProductService::ImportProductsService.new(csv_data).execute
  end
end
