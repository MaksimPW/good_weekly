Rails.application.routes.draw do
  devise_for :users
  root 'good_weeks#index'
  resources :good_weeks
end
