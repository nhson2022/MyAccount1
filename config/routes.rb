Rails.application.routes.draw do
  root 'pages#home'
  get 'info' => 'pages#info', as: :info
  devise_for :users
end
