Rails.application.routes.draw do
  root "entries#index"

  resources :entries, only: [ :index, :new, :create, :destroy ] do
    collection do
      get "food_macros"
    end
  end

  resources :foods

  get "up" => "rails/health#show", as: :rails_health_check
end
