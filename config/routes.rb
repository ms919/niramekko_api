Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :videos, only: [:new, :create]
      resources :playlists, only: [:index]
      resources :game_results, only: [:create]
      resources :laughed_videos, only: [:create]
      resource :users, only: [:show]
      get 'auth/:provider/callback', to: 'sessions#create'
      get 'logout', to: 'sessions#destroy'
      get 'auth/failure', to: 'sessions#failure'
    end
  end
end
