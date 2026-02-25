Rails.application.routes.draw do

  root 'main_pages#home'

  get "/contact", to:"main_pages#contact"

  get "/signup",  to:"users#new"
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
