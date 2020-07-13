Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchants/search#show'
      get 'merchants/most_revenue', to: 'merchants/revenue#show'
      get 'items/find', to: 'items/search#show'
      resources :items, except: [:new, :edit] do
        get 'merchant', to: 'items/merchants#show'
      end
      resources :merchants, except: [:new, :edit] do
        get 'items', to: 'items#show'
      end

    end
  end
end
