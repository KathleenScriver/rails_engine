Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'customers/find', to: 'customers/search#show'
      get 'customers/find_all', to: 'customers/search#index'
      get 'customers/:id/favorite_merchant', to: 'customers/favorite_merchant#show'
      resources :customers, only: [:index, :show]
      resources :invoices, only: [:index]
    end
  end
end
