Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  root to: 'home#index'
  
  resources :candidates, only: [:show, :edit, :update] do
    resource :messages, only: [:show, :new, :create]
  end

  resources :headhunters do
    resource :messages, only: [:show, :new, :create]
  end
  
  resources :messages, only: [:index]

  resources :jobs, only: [:index, :show, :new, :create] do
    get 'search', on: :collection
    get 'chance_status', on: :member
    resources :subscriptions, only: [:new, :create]
  end

  resources :subscriptions, only: :index do
    get 'change_featured_profile', on: :member
    get 'edit_denial', on: :member
    post 'denial', on: :member
    
    resources :proposes, only: [:new, :create, :show] do
      get 'accept', on: :member
      get 'edit_denial', on: :member
      post 'denial', on: :member
    end
  end

end
