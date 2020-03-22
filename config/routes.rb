Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      resources :loads do
        resources :orders, only: [:create, :index]
      end

      resources :orders, only: [:show, :update, :destroy] do
        resources :order_products, except: [:show]
        resources :ordenated_order_products, only: [:index]
      end
      
      post '/order/:id/organize', to: 'orders#organize'
      get '/orders/:id/ordenated', to: 'orders#show_ordenated'
      
      resources :products
    end
  end
end
