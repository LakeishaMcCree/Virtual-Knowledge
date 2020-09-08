Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :meetings 
  root to: "home#index"

  get "/signup", to: "users#new", as: "signup"
  post "/signup", to: "users#create"

  get "/login", to: "meetings#new", as: "login"
  post "/login", to: "meetings#create"

  delete "/logout", to: "meetings#destroy", as: "logout"
  #resources :meetings 
  resources :users, only: [] do
    resources :meetings, only: [:index]
  end

  get 'active-sessions', to: "meetings#active_sessions"
  
  resources :users, only: [:index]

end
