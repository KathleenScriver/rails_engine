Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'customers/find', to: 'customers/search#show'
      get 'customers/find_all', to: 'customers/search#index'
      get 'customers/:id/favorite_merchant', to: 'customers/favorite_merchant#show'
      get 'customers/random', to: 'customers/random#show'
      resources :customers, only: [:index, :show]
      get 'invoices/find', to: 'invoices/search#show'
      get 'invoices/find_all', to: 'invoices/search#index'
      resources :invoices, only: [:index, :show]
    end
  end
end
