require Rails.root.join("app/graphql/my_schema")

class Api::V1::GraphqlController < ApplicationController
  def execute
    result = MySchema.execute(
      params[:query],
      variables: params[:variables],
    )
    render json: result
  end
end
