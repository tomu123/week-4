Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root 'products#index'
  resources :products do
    resources :line_items, only: %i[create]
    resource :like, only: %i[create destroy]
    resources :comments, only: %i[create], defaults: { commentable_type: 'Product' }
  end
  resource :cart, only: [:show] do
    get 'checkout'
  end
  resources :line_items, only: %i[destroy]
  resolve('Cart') { [:cart] }
  resources :orders do
    resources :comments, only: %i[create], defaults: { commentable_type: 'Order' }
  end
  resources :comments, only: %i[edit update destroy]
  resources :tags, except: [:show]
end
