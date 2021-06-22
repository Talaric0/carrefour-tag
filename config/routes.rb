Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/cartao', to: 'pages#cartao' 

  #TAG related routes
  get '/tag', to: 'pages#tag'
  get '/tag_info', to: 'pages#tag_info'
  resources :tags, only: [ :index, :show, :new, :create, :edit, :update, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
