Rails.application.routes.draw do
  devise_for :users
  get 'team', to: 'pages#team'
  root to: 'pages#home'
  resources :offers, only: [:index, :show] do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:index, :new, :destroy]
  resources :notifications, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
