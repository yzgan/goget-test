Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { sessions: :sessions, registrations: :registrations }, path: '', path_names: { sign_in: :login, sign_out: :logout, registration: :signup }

  scope :api, defaults: { format: :json } do
    resources :delivery_jobs do
      collection do
        get :others
      end
      member do
        post :claim
        post :execute
      end
    end
  end
end
