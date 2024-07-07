Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'dashboard', to: 'dashboards#index'
  get "play", to: "games#game"

  resources :chatrooms, only: [:show, :new, :create, :edit, :update] do
    resources :messages, only: [:create]
  end

  resources :messages, only: [:destroy]

  resources :games, only: [:index, :show, :create, :new] do
    post "guess_word", on: :member
    post "next", on: :member
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
