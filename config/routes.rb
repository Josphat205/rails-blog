Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users do
    resources :posts do
      resources :comments
      resources :likes, only: [:create]
    end
  end

  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, param: :_user_id
  post 'api/v1/auth/login', to: 'authentication#login'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index , :show, :create] do
        resources :posts, only: [:index , :show, :create] do 
          resources :comments, only: [:index , :show , :create]
        end
      end
    end
  end

  # Defines the root path route ("/")
  root 'users#index'
end
