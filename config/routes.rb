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
    post 'checkout', on: :member
  end
  resources :line_items, only: %i[destroy]
  resolve('Cart') { [:cart] }
  resources :orders, only: %i[index show] do
    resources :comments, only: %i[create], defaults: { commentable_type: 'Order' }
  end
  resources :comments, only: %i[edit update destroy]
  resources :tags, except: [:show]
  resources :product_tags, only: %i[destroy]
  resources :stripe_transactions, only: %i[index]

  # Sidekiq Web UI, only for admins.
  require 'sidekiq/web'
  authenticate :user, ->(user) { user.admin_role? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # api routes

  namespace :api do
    namespace :v1 do
      # swagger-blocks
      namespace :swagger_blocks do
        resources :apidocs, only: [:index]
      end

      # public

      post 'auth/login', to: 'authentication#login'
      resources :products, only: %i[show index]
      post 'stripe_webhooks', to: 'stripe#stripe_webhooks'

      # admin

      namespace :admin do
        resources :products, only: %i[create update destroy] do
          patch 'recover', on: :member
        end
        resources :comments, only: %i[destroy index show] do
          patch 'approve', on: :member
        end
        resources :users, only: %i[create update destroy index show] do
          patch 'recover', on: :member
        end
        resources :stripe_transactions, only: %i[index show]
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
        resources :orders, only: %i[index show]
        resources :users, only: [] do
          resources :comments, only: %i[create]
        end
        resources :comments, only: %i[index show]
        resource :cart, only: [:show] do
          resources :line_items, only: %i[update destroy] do
            post 'add_product', on: :collection
          end
          post 'checkout', on: :member
        end
        resources :stripe_transactions, only: %i[index show]
      end
    end
  end
end
