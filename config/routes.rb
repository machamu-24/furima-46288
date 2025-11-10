Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resource :items, only: [:index, :new, :create]
end
