Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :user, only: [:create,:index]
  resources :post
  post "/login",  to:"user#login"
  delete "/user", to:"user#destroy"

end