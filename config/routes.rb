Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/signout', to: 'devise/sessions#destroy', as: :signout
  end
  get 'fs_focus_items/selected'
  resources :fs_focus_items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'fs_focus_items#index'
end
