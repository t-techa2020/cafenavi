Rails.application.routes.draw do
  root to: 'toppages#index'
  
  # get 'login', to: 'sessions#new'
  # post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  resources :users, only: [:index, :new, :show, :create] do
    member do
      get :followings
      get :followers
    end
  end
  
  get 'likes', to: 'user#likes'
  resources :users, only: [:index, :show, :new, :create, :destroy] do
    member do
      get :likes
    end
  end
  
  resources :cafeposts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :search
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only:[:create, :destroy]
  
  devise_for :owners, controllers: {
    registrations: 'owners/registrations',
    sessions: 'owners/sessions'
  }
  resources :owners, only: [:index, :new, :show, :create, :destroy]
  
  resources :beanposts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :search
    end
  end
end
