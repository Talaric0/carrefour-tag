Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/cartao', to: 'pages#cartao' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
