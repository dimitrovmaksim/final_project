Rails.application.routes.draw do
  get 'log_out' => 'sessions#destroy', :as => 'log_out'
  get 'log_in' => 'sessions#new', :as => 'log_in'
  get 'sign_up' => 'users#new', :as => 'sign_up'
  get 'articles/index'
  root 'articles#index'
  resources :articles do
    resources :comments
  end
  resources :users
  resources :sessions
  resources :tags, only: [:show, :index, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
