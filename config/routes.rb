Rails.application.routes.draw do
  root "pages#home"
  get "info" => "pages#info", as: :info

  # for normal user
  resources :articles, only: [] do
    get "/" => "articles#index", on: :collection, as: :list
    get "/:id" => "articles#show", on: :collection, as: :detail
  end

  # for Admin user
  devise_for :users
  namespace :admin do
    resources :articles
  end
end
