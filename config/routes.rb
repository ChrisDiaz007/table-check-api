Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'api/v1/sessions',
    registrations: 'api/v1/registrations'
  }

  namespace :api, defaults: { format: :json} do
    namespace :v1 do

      resources :restaurants do
        resources :reservations, only: [ :index, :show, :create, :update ]
        resources :tables, only: [ :index, :create, :update, :destroy ]
        resources :restaurant_hours, only: [ :index, :create, :update, :destroy]
      end

      resources :users, only: [ :index, :show, :update ] do
        member do
          get :restaurants, :reservations
        end
      end

      resources :cuisines, only: [ :index, :show ]
      resources :cuisines_restaurants, only: [ :create, :destroy]

      post 'refresh_token', to: 'tokens#refresh_token'

    end
  end

end
