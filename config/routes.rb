Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root :to => "customers#index"
  end

  get 'settings', to: 'setting#settings'

  resources :orders
  resources :products
  resources :customers

end
