Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root :to => "customers#index"
  end

  resources :orders
  resources :products
  resources :customers

end
