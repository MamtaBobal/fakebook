Rails.application.routes.draw do
  root 'users#index'
  devise_for :users
  resources :users, only: %i[index show] do
    resources :friendships, only: %i[create]
  end
  resources :posts do
    resources :likes, only: %i[create]
  end
  resources :comments, only: %i[new create destroy] do
    resoources :likes, only: %i[create]
  end
end
