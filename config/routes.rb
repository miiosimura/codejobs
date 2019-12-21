Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  root to: 'home#index'
  resources :candidates
  resources :jobs do
    get 'search', on: :collection
  end

  resources :subscriptions
end
