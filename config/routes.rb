Rails.application.routes.draw do
  resources :activities
  get "bulk_add_users", to: "bulk_add_users#index"
  get "bulk_add_users/show", to: "bulk_add_users#show"
  post "bulk_add_users/create", to: "bulk_add_users#create"
  get "bulk_add_users/confirmed", to: "bulk_add_users#confirmed"
  get '/activities/:id', to: 'activities#show'
  get 'profile/profile'

  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  get 'authorized', to: 'sessions#page_requires_login'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#welcome'
  get 'profile', to: 'profile#profile'
  get "profile/attendance"
  get 'activities', to: 'activities#activities'
  

  resources :members do
    member do
      get:delete
    end
  end

end
