Rails.application.routes.draw do
  root 'home/home#index'
  
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  get 'logout' => 'user_sessions#destroy', :as => :logout
  post 'logout' => 'user_sessions#destroy'
  
  get 'login_signup' =>'user_sessions#login_signup'

  get 'login_partial' =>'user_sessions#login_partial'
  get 'signup_partial' => 'user_sessions#signup_partial'

  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

namespace :p5 do
  resources :sketches, only: [:show, :index]
end

  get '/p5', to: 'p5#index'
  get 'p5/update', to: 'p5#update', as: 'update_p5'

  # Defines the root path route ("/")
  # root "posts#index"
end
