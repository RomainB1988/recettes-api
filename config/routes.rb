Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :recipes do
        resources :comments, only: [:index, :create, :destroy]
        member do
          post :favorite
          delete :unfavorite
        end
        collection do
          get :favorites
        end
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
