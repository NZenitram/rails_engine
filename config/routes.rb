Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :merchants, only: [:index, :show]

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :transactions, only: [:index, :show]

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :customers, only: [:index, :show]

      namespace :invoices do
        get '/:id/transactions', to: 'search#index'
      end
      resources :invoices, only: [:index, :show]

      resources :items, only: [:index, :show]

      resources :invoice_items, only: [:index, :show]
    end
  end
end
