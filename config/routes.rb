Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'revenue', to: 'revenue#show'
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'most_revenue', to: 'revenue#index'
        get 'most_items', to: 'most_items#index'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      resources :merchants, except: [:new, :edit] do
        get 'items', to: 'merchants/items#index'
        get 'revenue', to: 'merchants/revenue#show'
      end
      namespace :items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      resources :items, except: [:new, :edit] do
        get 'merchant', to: 'items/merchants#show'
      end


    end
  end
end
