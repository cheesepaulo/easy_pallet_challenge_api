Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :loads, only: [:index, :show]
      resources :orders, only: [:show]
    end
  end
end
