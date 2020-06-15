Rails.application.routes.draw do
  resources :elections
  resources :people
  resources :committees
  resources :measures
  resources :candidates
  resources :reports
  resources :incumbents
  resources :districts
  resources :jurisdictions
  root 'jurisdictions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
