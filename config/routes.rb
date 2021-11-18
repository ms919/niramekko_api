Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :videos, only: [:create]
      resources :playlists, only: [:index]
      resources :game_results, only: [:create]
      resources :laughed_videos, only: [:create]
      resource :users, only: [:show]
      # post 'sessions', to: 'sessions#create'
      get 'auth/:provider/callback', to: 'sessions#create'
      get 'logout', to: 'sessions#destroy'
      get 'auth/failure', to: 'sessions#failure'
    end
  end
  # get 'auth/failure', to: 'api/v1/sessions#failure'
  # get 'auth/:provider/callback', to: 'api/v1/sessions#create'
  # get 'logout', to: 'api/v1/sessions#destroy'
end
