Ecomm::Application.routes.draw do
  default_url_options host: AppConfig.mailer.host

  devise_for :users

  get '/404' => 'errors#not_found'
  get '/500' => 'errors#internal_server_error'

  root to: 'store#index'

  # Main namespace
  get '/store/index'
  get '/store/search' => 'store#search', as: :store_search

  resources :pages, only: [:show]

  resources :products, only: [:show] do
    get ':seo_name', action: :show, as: :seo, on: :member
  end

  resources :categories, only: [:show] do
    get ':seo_name', action: :show, as: :seo, on: :member
  end

  resources :orders, only: [:new, :create, :show, :update, :destroy]

  resources :cart_items, only: [:index, :create, :update, :destroy] do
    delete :index, on: :collection, action: :delete_all
    member do
      post 'increase'
      post 'decrease'
    end
  end

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

      resources :product_attribute_names, only: [:create, :update, :destroy] do
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
