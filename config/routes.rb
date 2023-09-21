Rails.application.routes.draw do
  devise_for :users
  resources :messages, only: [:new, :create, :index]

  root to: 'home#index'

end
