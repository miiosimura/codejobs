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
    get 'edit_denial', on: :member
    post 'denial', on: :member
    
    resources :proposes, only: [:index, :new, :create, :show] do
      get 'accept', on: :member
      get 'edit_denial', on: :member
      post 'denial', on: :member
    end
  end
  
  resources :messages, only: [:index, :show, :new, :create]
end
