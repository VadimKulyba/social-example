Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users

  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  post 'sessions', to: 'sessions#create'

  get 'home', to: 'static_pages#home'
  get 'help', to: 'static_pages#help'
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  root 'static_pages#home'
end
