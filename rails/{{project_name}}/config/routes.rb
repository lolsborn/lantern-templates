Rails.application.routes.draw do
  # Health check
  get '/health', to: 'health#show'

  # API routes
  namespace :api do
    namespace :v1 do
      # Authentication
      devise_for :users, controllers: {
        sessions: 'api/v1/auth/sessions',
        registrations: 'api/v1/auth/registrations'
      }

      # Users
      resources :users, except: [:new, :edit]

      # Current user
      get '/me', to: 'users#me'
    end
  end

  # Error handling
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end