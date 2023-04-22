# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/graphql", to: "graphql#execute"
      resources :products do
        collection do
          post "import", action: "import_products"
        end
      end
    end
  end
  # post 'api/v1/products/import', :to => 'api/v1/products#import_products'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
