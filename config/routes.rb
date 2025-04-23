Rails.application.routes.draw do
  root to: "job_cards#index"

  resources :job_cards do
    resources :job_applications, only: [:create, :index, :update]
  end

  resources :profiles do
    member do
      get :job_cards
      get :stats
      get :foreman_description
      post :foreman_description
    end
    resources :experiences, only: %i[create new  update destroy edit]
  end
  

  devise_for :users, controllers: { registrations: "users/registrations" }

  devise_scope :user do
  end

  get "/vineyard_auth", to: "vineyard_auth#new", as: :new_vineyard_auth
  post "/vineyard_auth", to: "vineyard_auth#create", as: :vineyard_auth

  get "up" => "rails/health#show", as: :rails_health_check
end
