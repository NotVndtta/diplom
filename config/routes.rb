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
      get :show_modal, on: :member
    end

    resources :ratings, only: %i[create destroy]
  end

  resources :media_files, only: %i[index new create destroy] do
    get :show_modal, on: :collection
    post :attach_to_job_card, on: :member
    post :attach_to_job_card, on: :member
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }


  get '/manifest.json', to: 'pwa#manifest'
  get '/service-worker.js', to: 'pwa#service_worker'
  get '/offline', to: 'pwa#offline'


  devise_scope :user do
  end

  get "/vineyard_auth", to: "vineyard_auth#new", as: :new_vineyard_auth
  post "/vineyard_auth", to: "vineyard_auth#create", as: :vineyard_auth

  get "up" => "rails/health#show", as: :rails_health_check
end
