Rails.application.routes.draw do
  resources :articles
  root 'pages#home'
  get 'info' => 'pages#info', as: :info
  devise_for :users
end
