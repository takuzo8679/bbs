Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'boards', to: 'boards#index'
  get 'boards/new', to: 'boards#new'
  post 'boards', to: 'boards#create'
end
