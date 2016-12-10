Rails.application.routes.draw do


# ESSA ROTA DO MANAGE TEM QUE SER A PRIMEIRA
# Rotas que atendem ao ambiente BACKOFFICE
  namespace :manage do
    root to: 'home#index'
    resources :newsletters, only: [:index]
    resources :products do
      collection do
        post :gallery_change
        get 'cart_floating'
      end
    end
    resources :customers
    resources :categories
    resources :orders, only: [:index, :show]
  end

 ## Rotas que atendem ao ambiente PAINEL DO USUÁRIO
    namespace :panel do
      root to: 'my_orders#index'
      resources :my_orders, only: [:index, :show]
      resources :addresses do
        collection do
          get :xhr_update
        end
      end
      resources :my_personal_details, only: [:index, :show, :edit]
      patch 'my_personal_details/customer', to: 'my_personal_details#customer'

    end

# Rota RAIZ
  root to: 'home#index'
  match '/shipping', via: :get, to: 'application#shipping', as: :shipping  
  
# Rotas que atendem ao DEVISE
  devise_for :customers, :path => '/', :path_names => {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
## Rotas que atendem ao PRODUCTS

  resources :products, controller: :shops, only: [:index]
  resources :products, only: [:show] do
    collection do
      get :xhr_mail_shipping
    end
  end
## Rotas que atendem ao SHOPS
  resources :shops do
    collection do
      get 'cart_floating'
    end
  end

## Rotas que atendem ao CHECKOUT
resources :newsletters, only: [:create]
get '/checkout', to: 'checkout#index', as: :checkout
get '/success', to: 'checkout#order_success', as: :success
patch '/checkout/customer', to: 'checkout#customer'
get '/checkout/buy', to: 'checkout#buy'

## Rotas que atendem ao CARRINHO
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  get '/carts/postal_code', to: 'carts#postal_code'
  get 'carts/show'
  
end
