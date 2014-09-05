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

    resources :pages
    post '/pages/order' => 'pages#order', as: :pages_order

    resources :orders do
      resources :order_histories
    end

    post '/orders/:id/shipment_event/:event' => 'orders#shipment_event', as: :order_shipment_event
    post '/orders/:id/invoice_event/:event' => 'orders#invoice_event', as: :order_invoice_event
    post '/orders/:id/order_event/:event' => 'orders#order_event', as: :order_event

    resources :images, except: :update

    resources :brands
    post '/brands/order' => 'brands#order', as: :brands_order

    resources :categories do
      resources :product_attributes, only: [:create, :update, :destroy]
    end
    post '/categories/order' => 'categories#order', as: :categories_order

    resources :products do
      resources :images, only: [:create, :destroy, :show]
    end
    post '/products/clone/:id' => 'products#clone', as: :product_clone

    resources :users

    get '/preferences' => 'preferences#index'
    patch '/preferences' => 'preferences#update'
  end
end
