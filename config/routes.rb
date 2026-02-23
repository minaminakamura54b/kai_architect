Rails.application.routes.draw do
  root 'main_pages#home'
  get 'main_pages/contact'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
