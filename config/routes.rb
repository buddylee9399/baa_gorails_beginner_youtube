Rails.application.routes.draw do
  
  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  
  delete "logout", to: "sessions#destroy"
  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"
  
  # get "/auth/twitter/callback", to: "omniauth_callbacks#twitter"
  # get "/auth/twitter/callback", to: "omniauth_callbacks#twitter"
  get "/auth/twitter2/callback", to: "omniauth_callbacks#twitter2"

  # get "about-us", to: 'about#index', as: :about
  # get "about-us", to: 'about#index'
  get "about", to: 'about#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get '', to: 'main#index'
  # get '/', to: 'main#index'
  # root to: "main#index"
  root "main#index"
  # root "articles#index"

  resources :twitter_accounts
  resources :tweets
  resources :posts
end
