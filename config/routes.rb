Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root 'products#index'
  resources :products do
    resources :line_items, only: %i[create]
  end
  resource :cart, only: [:show] do
    get 'checkout'
  end
  resources :line_items, only: %i[destroy]
  resolve('Cart') { [:cart] }
  resources :orders
end
