require Rails.root.join("app/graphql/schema")

class Api::V1::GraphqlController < ApplicationController
  def execute
    result = Schema.execute(
      params[:query],
      variables: params[:variables],
    )
    render json: result
  end
end
