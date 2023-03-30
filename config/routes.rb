Rails.application.routes.draw do
  # get "about-us", to: 'about#index', as: :about
  # get "about-us", to: 'about#index'
  get "about", to: 'about#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get '', to: 'main#index'
  # get '/', to: 'main#index'
  # root to: "main#index"
  root "main#index"
  # root "articles#index"
end
