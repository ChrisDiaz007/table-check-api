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

      resources :restaurants

      resources :users, only: [ :index, :show, :update ] do
        member do
          get :restaurants
        end
      end

      resources :cuisines, only: [ :index ]

      post 'refresh_token', to: 'tokens#refresh_token'

    end
  end

end
