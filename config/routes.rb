Rails.application.routes.draw do
  root 'static_pages#home'

  resources :expenses
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end