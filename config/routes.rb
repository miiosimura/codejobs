Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  root to: 'home#index'
  get '/profile', to: 'candidates#profile'
  post '/profile', to: 'candidates#update_profile'
  resources :candidates, only: [:show]
end
