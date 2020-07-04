Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  delete 'resign', to: 'users#destroy'
  resources :users, only: [:index, :show, :new, :create, :destroy, :edit, :update] do
    member do
      get :followings
      get :followers
      get :likes
      get :joins
    end
  end
  
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :communities, only: [:show, :new, :create]
  resources :join_communities, only: [:create, :destroy]
end
