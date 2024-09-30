require 'sidekiq/web'
Rails.application.routes.draw do
  resources :blogs do
    collection do
      post 'import'
    end
  end
  resources :employees
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "blogs#index"
  mount Sidekiq::Web => '/sidekiq'
end
