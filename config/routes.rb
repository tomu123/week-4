# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root 'products#index'
  resources :products do
    resources :line_items, only: %i[create]
    resource :like, only: %i[create destroy]
    resources :comments, only: %i[create], defaults: { commentable_type: 'Product' }
    resources :product_tags, only: %i[create]
  end
  resource :cart, only: [:show] do
    get 'checkout'
  end
  resources :line_items, only: %i[destroy]
  resolve('Cart') { [:cart] }
  resources :orders, only: %i[index show] do
    resources :comments, only: %i[create], defaults: { commentable_type: 'Order' }
  end
  resources :comments, only: %i[edit update destroy]
  resources :tags, except: [:show]
  resources :product_tags, only: %i[destroy]

  # api routes

  namespace :api do
    namespace :v1 do
      # public

      resources :products, only: %i[show index]
      resource :cart, only: [:show] do
        resources :line_items, except: %i[edit new index], shallow: true
      end

      # admin
      namespace :admin do
        resources :products, only: %i[create update destroy]
        resources :users, only: [] do
          resources :orders, only: [:index]
        end
        resources :orders, only: [:show]
      end

      # support

      namespace :support do
        resources :products, only: [:update]
      end

      # customer
      namespace :customer do
        resources :products, only: [] do
          resource :like, only: %i[create destroy]
        end
        resources :orders, only: %i[show]
      end
    end
  end
end
