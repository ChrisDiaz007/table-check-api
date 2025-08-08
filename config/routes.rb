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
        post :upload_photo #remove later
      end

      resources :users, only: [ :index, :show ]

      devise_scope :user do
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
      end

    end
  end

end
