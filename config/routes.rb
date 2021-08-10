Rails.application.routes.draw do
  resources :categories
  devise_for :users
  root to: 'articles#index'

  resources :articles, except: [:destroy]
end
