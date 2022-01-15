Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :videos, only: [:index, :new, :create, :update, :destroy]
      resources :playlists, only: [:index, :show], param: :mode
      resources :game_results, only: [:create]
      resources :laughed_videos, only: [:create]
      resources :hidden_videos, only: [:index, :create, :destroy]
      resource :user, only: [:show, :update, :destroy]
      resources :user_notifications, only: [:update]
      resources :contacts, only: [:create]
      get 'auth/:provider/callback', to: 'auth#create'
      get 'auth/failure', to: 'auth#failure'
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
      namespace :admin do
        resources :videos, only: [:index, :destroy]
        resources :users, only: [:index, :destroy]
        resources :contacts, only: [:index, :update, :destroy]
      end
    end
  end
end
