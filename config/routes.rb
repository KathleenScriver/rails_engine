Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'customers/find', to: 'customers/search#show'
      get 'customers/find_all', to: 'customers/search#index'
      resources :customers, only: [:index, :show]
      resources :invoices, only: [:index]
    end
  end
end
