Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  # devise
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
  end

  resources :users, only: %i[index show] do
    member do
      get :likes
    end
  end

  resources :posts do
    resources :comments, only: %i[create destroy]
  end

  resources :relationships, only: %i[create destroy]
  resources :favorites, only: %i[create destroy]

  get 'tags/:tag', to: 'home#index', as: :tag
  get 'likes/tags/:tag', to: 'users#likes', as: :likes_tag

  # ヘルスチェック用簡易ページ
  get '/health' => 'elb#health'
end
