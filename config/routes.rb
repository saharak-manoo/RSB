Rails.application.routes.draw do
  get '/dashboard', to: 'dashboard#index'

  devise_for :users, path: '', path_names: {
    sign_in: "login",
    sign_out: "logout",
    sign_up: "register"
  }

  devise_scope :user do
    authenticated :user do
      root 'dashboard#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :stocks do
    member do
      get '/logs', to: 'stocks#logs'
    end
    resources :stock_histories, path: 'check'
  end

  resources :logs, only: [:index]
end
