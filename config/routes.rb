Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index' # 実際にページはないがヘッダーを作る都合で作成
  resources :boards
  resources :comments, only: %i[create destroy]
end
