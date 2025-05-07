Rails.application.routes.draw do
  root to: "job_cards#index"

  resources :job_cards do
    resources :job_applications, only: %i[create index update]
    resources :ratings, only: %i[create destroy]
    resources :job_card_media, only: %i[new create destroy]
  end

  resources :profiles do
    member do
      get :responses
      get :job_cards
      get :stats
      get :foreman_description
      post :foreman_description
    end

    resources :experiences, only: %i[create new update destroy edit] do
      member do
        get :show_modal
      end
    end

    resources :ratings, only: %i[create destroy]
  end

  resources :media_files, only: %i[index new create destroy] do
    collection do
      get :show_modal
    end
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  devise_scope :user do
  end

  get "/vineyard_auth", to: "vineyard_auth#new", as: :new_vineyard_auth
  post "/vineyard_auth", to: "vineyard_auth#create", as: :vineyard_auth

  get "up" => "rails/health#show", as: :rails_health_check
end
