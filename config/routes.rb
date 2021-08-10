Rails.application.routes.draw do
  resources :subscriptions, only: [:index]
  resources :categories
  devise_for :users
  root to: 'articles#index'

  resources :articles, except: [:destroy]
  resources :order_items, only: [:create]
  resources :orders, only: [:show] do
    get '/current', to: 'orders#current', on: :collection
  end
  resources :checkout, only: [:create]
  post 'webhook', to: 'webhook#receive'
  get 'profile', to: 'users#profile'
end
