Rails.application.routes.draw do
  root to: 'toppages#index'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  resources :users, only: [:index, :new, :show, :create, :destroy] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
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
  
  resources :owners, only: [:index, :new, :show, :create, :destroy]
  
  resources :beanposts do
    collection do
      get :search
    end
  end
end
