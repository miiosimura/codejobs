Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  root to: 'home#index'
  
  resources :candidates
  resources :jobs do
    get 'search', on: :collection
    resources :subscriptions
  end

  resources :subscriptions, only: :index do
    get 'change_featured_profile', on: :member
  end
  resources :messages
end
