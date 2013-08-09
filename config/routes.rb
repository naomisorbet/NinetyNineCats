NinetyNineCats::Application.routes.draw do
  resources :cats
  resources :users, only: [:new, :create]
  resources :cat_rental_requests, except: [:edit, :delete]
  resources :sessions, only: [:new, :create, :delete]
end
