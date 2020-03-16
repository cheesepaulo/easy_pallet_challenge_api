Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :loads, only: [:index, :show]
      resources :orders, only: [:show]
      post '/order/:id/organize', to: 'orders#organize'
    end
  end
end
