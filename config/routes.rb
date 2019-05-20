Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/index'

  root to: "home#index"

  # devise
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

  resources :users, only: [:show] do
    member do
      get :followings
      get :followers
    end
  end
  resources :posts do
      # コメント機能　destroy追加予定
    resources :comments, only: [:create]
  end
  # フォロー機能
  resources :relationships, only: [:create, :destroy]

end
