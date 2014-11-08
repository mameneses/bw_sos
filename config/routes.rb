Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root :to => "customers#index"
  end

  # get 'settings', to: 'settings#settings'
  # post 'settings', to: 'settings#update'

  resources :orders
  resources :products
  resources :customers

end
