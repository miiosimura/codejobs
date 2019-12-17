Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  root to: 'home#index'
  resources :candidates
  resources :jobs, only: [:show, :new, :create]
end
