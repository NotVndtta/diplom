Rails.application.routes.draw do
  resources :job_cards
  resources :profiles do
    resources :experiences
  end

  devise_for :users, controllers: { registrations: "users/registrations" }

  root to: "job_cards#index"

  devise_scope :user do
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
