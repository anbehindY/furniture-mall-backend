Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, path: "", path_names: {
                       sign_in: "login",
                       sign_out: "logout",
                       registration: "signup",
                     },
                     controllers: {
                       sessions: "users/sessions",
                       registrations: "users/registrations",
                     }

  namespace :api do
    namespace :v1 do
      resources :furnitures do
        resources :appointments
      end

      resources :users do
        resources :appointments
      end
     resources :appointments, only:[:index, :destroy]
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
