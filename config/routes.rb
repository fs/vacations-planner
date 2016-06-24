Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: "pages#home"

  resources :vacation_requests, except: %i(show)
  # resources :vacation_requests, only: %i(new create)
end
