Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/cartao', to: 'pages#cartao'
  get '/perfil', to: 'pages#perfil', as: 'perfil'

  #TAG related routes
  get '/tag', to: 'pages#tag', as: 'tags_page_path'
  get '/tag_info', to: 'pages#tag_info'
  get '/tag_success', to: 'tags#tag_success'
  resources :tags, only: [ :index, :show, :new, :create, :edit, :update, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
