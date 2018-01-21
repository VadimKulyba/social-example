Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :microposts, only: %i[create destroy] #do
  #  resources :comments
  #end

  resources :relationships, only: %i[create destroy]

  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  post 'sessions', to: 'sessions#create'

  get 'home', to: 'static_pages#home'
  get 'help', to: 'static_pages#help'
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  root 'static_pages#home'
end
