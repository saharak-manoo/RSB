Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'home#index', as: :unauthenticated_root
    end
  end

  resources :branch_products, path: 'check-stocks' do
    collection do
      get :products
    end
  end
end
