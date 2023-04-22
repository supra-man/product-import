# frozen_string_literal: true

require "rails_helper"
Sidekiq::Testing.fake!

RSpec.describe ImportProductWorker, type: :worker do
  it "shoudl create a queue" do
    ImportProductWorker.perform_async(csv_data: "123:12,11:11")
    expect(ImportProductWorker.jobs.size).to eq(1)
  end
end
