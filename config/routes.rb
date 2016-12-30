Rails.application.routes.draw do
  root 'good_weeks#index'
  resources :good_weeks
end
