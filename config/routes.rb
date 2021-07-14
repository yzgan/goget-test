Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: :sessions, registrations: :registrations }, path: '', path_names: { sign_in: :login, sign_out: :logout, registration: :signup }


  # scope :api, defaults: { format: :json } do
    
  # end
end
