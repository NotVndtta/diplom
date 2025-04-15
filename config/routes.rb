Rails.application.routes.draw do
  resources :job_cards

  resources :profiles do
    resources :experiences, only: %i[create new show update destroy edit]
  end

  devise_for :users, controllers: { registrations: "users/registrations" }

  root to: "job_cards#index"

  devise_scope :user do
  end

  get "/vineyard_auth", to: "vineyard_auth#new", as: :new_vineyard_auth
  post "/vineyard_auth", to: "vineyard_auth#create", as: :vineyard_auth
  


  get "up" => "rails/health#show", as: :rails_health_check
end
