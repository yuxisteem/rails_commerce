Ecomm::Application.routes.draw do
  default_url_options host: AppConfig.mailer.host

  get '/404' => 'errors#not_found'
  get '/500' => 'errors#internal_server_error'

  resources :pages, only: [:show]

  get '/products/:id/:seo_name' => 'products#show', as: :product_seo
  resources :products, only: [:show]

  get '/categories/:id/:seo_name' => 'categories#show', as: :category_seo
  resources :categories, only: [:show]

  # Checkout controller
  resources :orders, only: [:new, :create, :show, :update, :destroy]

  # Cart controller
  resources :cart_items, only: [:index, :create, :update, :destroy]
  delete '/cart_items' => 'cart_items#destroy'
  post '/cart_items/:id/increase' => 'cart_items#increase', as: :cart_item_increase
  post '/cart_items/:id/decrease' => 'cart_items#decrease', as: :cart_item_decrease

  # Main namespace
  get '/store/index'
  get '/store/search' => 'store#search', as: :store_search

  root to: 'store#index'

  devise_for :users

  # Admin panel
  namespace :admin do
    get '/' => 'dashboard#index'

    resources :pages do
      post 'order', on: :collection
    end

    resources :orders do
      resources :order_histories, only: [:create]

      resource :shipment, only: [] do
        post 'event', on: :member
      end

      resource :invoice, only: [] do
        post 'event', on: :member
      end

      post 'event', on: :member
    end


    resources :images, except: :update

    resources :brands do
      post 'order', on: :collection
    end

    resources :categories do
      post 'order', on: :collection

      resources :product_attributes, only: [:create, :update, :destroy] do
        post 'order', on: :collection
      end
    end

    resources :products do
      member do
        post 'clone'
      end

      resources :images, only: [:create, :destroy, :show]
    end

    resources :users

    get '/preferences' => 'preferences#index'
    patch '/preferences' => 'preferences#update'
  end
end
