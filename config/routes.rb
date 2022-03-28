Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root 'products#index'
  resources :products do
    member do
      post 'add_to_cart'
    end
    collection do
      get 'search'
    end
  end
  resource :cart, only: [:show] do
    get 'checkout'
  end
  resources :orders
end
