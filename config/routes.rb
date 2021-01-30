Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#new'
  
  post '/users/signin', to: "users#signin"
  post '/users/signout', to: "users#signout"
  resources :users, only: [:new, :create, :show]
end
