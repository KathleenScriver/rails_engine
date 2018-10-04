Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :customers do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get ':id/favorite_merchant', to: 'favorite_merchant#show'
        get 'random', to: 'random#show'
      end

      namespace :invoices do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
      end

      resources :customers, only: [:index, :show]

      resources :invoices, only: [:index, :show]
      get 'merchants/most_revenue', to: 'merchants/most_revenue#index'

    end
  end
end
