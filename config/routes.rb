Rails.application.routes.draw do
  root to: 'toppages#index'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  resources :users, only: [:index, :show] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  get 'likes', to: 'user#likes'
  
  resources :relationships, only: [:create, :destroy]
  
  resources :favorites, only:[:create, :destroy]
  
  resources :cafeposts do
    collection do
      get :search
    end
  end
  
  devise_for :owners, controllers: {
    registrations: 'owners/registrations',
    sessions: 'owners/sessions'
  }
  
  resources :owners, only: [:index, :show]
  
  resources :beanposts do
    collection do
      get :search
    end
  end
end
