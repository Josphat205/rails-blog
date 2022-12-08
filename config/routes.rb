Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users do
    resources :posts do
      resources :comments, only: %i[new create]
      resources :likes, only: [:create]
    end
  end

  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end

  # Defines the root path route ("/")
  root 'users#index'
end
