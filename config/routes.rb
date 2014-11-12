Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  devise_scope :user do
    root :to => "customers#index"
  end

  
  resources :orders
  resources :products
  resources :customers
  resources :settings, :only => [:index, :update]
end
