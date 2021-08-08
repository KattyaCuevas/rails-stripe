Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'

  resources :articles, except: [:destroy]
  resources :order_items, only: [:create]
  resources :orders do
    get '/current', to: 'orders#current', on: :collection
    get '/checkout', to: 'orders#checkout'
  end
end
