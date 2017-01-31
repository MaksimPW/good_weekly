Rails.application.routes.draw do
  devise_for :users
  root 'good_weeks#index'
  resources :good_weeks, only: :index
  get :current_week, to: 'good_weeks#current_week'
  get 'week/:year/:week', to: 'good_weeks#show', as: 'week'
  resources :books
  resources :people
end
