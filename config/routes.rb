Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :loads
      resources :orders, only: [:show]
      post '/order/:id/organize', to: 'orders#organize'
      get '/orders/:id/ordenated', to: 'orders#show_ordenated'
    end
  end
end
