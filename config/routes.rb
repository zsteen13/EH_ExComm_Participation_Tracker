# frozen_string_literal: true

# provides a redirected route while preserving query parameters
class QueryRedirector
  def call(_params, request)
    uri = URI.parse(request.original_url)
    if uri.query
      "#{@destination}?#{uri.query}"
    else
      @destination
    end
  end

  def initialize(destination)
    @destination = destination
  end
end

Rails.application.routes.draw do
  resources :activities
  get 'activities', to: 'activities#activities'

  get 'bulk_add_users', to: 'bulk_add_users#index'
  get 'bulk_add_users/show/', to: 'bulk_add_users#show'
  post 'bulk_add_users/create/', to: 'bulk_add_users#create'
  get 'bulk_add_users/confirmed/', to: 'bulk_add_users#confirmed'
  get 'bulk_add_users/help', to: 'bulk_add_users#help'
  get 'bulk_add_users/correct_csv_all_fields', to: 'bulk_add_users#correct_csv_all_fields'
  get 'bulk_add_users/correct_csv_required_fields', to: 'bulk_add_users#correct_csv_required_fields'
  get 'bulk_add_users/correct_csv_some_optional_fields', to: 'bulk_add_users#correct_csv_some_optional_fields'
  get 'bulk_add_users/incorrect_csv_email_last_name_switched', to: 'bulk_add_users#incorrect_csv_email_last_name_switched'
  get 'bulk_add_users/incorrect_csv_not_enough_columns', to: 'bulk_add_users#incorrect_csv_not_enough_columns'

  get 'activities/:id', to: 'activities#show'

  get 'activities/:id/bulk_add', to: 'bulk_add_attendance#index'
  get 'bulk_add_attendance/:id/help', to: 'bulk_add_attendance#help'
  get 'bulk_add_attendance/correct_csv', to: 'bulk_add_attendance#correct_csv'
  get 'activities/:id/bulk_add/confirmed', to: 'bulk_add_attendance#confirmed'
  get 'activitites/:id/bulk_add/show', to: 'bulk_add_attendance#show'
  post 'activitites/:id/bulk_add/create', to: 'bulk_add_attendance#create'

  get 'profile/profile'
  get 'members/point_threshold', to: 'members#point_threshold'
  post 'members/point_threshold', to: 'members#update_point_threshold'

  resources :users, only: %i[new create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  get 'authorized', to: 'sessions#page_requires_login'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'profile#profile'
  get 'profile', to: 'profile#profile'

  get 'signup', to: redirect(QueryRedirector.new('/profile/change_password')) # looks nicer for first time users
  get 'profile/change_password', to: 'profile#will_change_password'
  patch 'profile/change_password', to: 'profile#change_password'
  get 'profile/error', to: 'profile#error'

  get 'profile/attendance'
  get 'activities', to: 'activities#activities'

  resources :committees, shallow: true do
    get :delete
    resources :subcommittees
  end

  get '/subcommittees/:subcommittee_id/delete', to: 'subcommittees#delete'

  resources :members do
    member do
      get :delete
    end
    collection do
      get 'show_threshold_points'
    end
  end

  get 'subcommittees_by_committee/:committee_id', to: 'members#subcommittees_by_committee'
end
