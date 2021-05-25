Rails.application.routes.draw do
  get 'bookings/index'
  devise_for :users
  root to: 'pages#home'
    resources :offers, only: [:index, :show]
    resources :bookings, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
