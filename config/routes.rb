Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users
  resources :expenditures
  resources :elections
  resources :people
  resources :committees
  resources :measures
  resources :reports
  resources :districts do
    collection {post :import}
  end
  resources :jurisdictions
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
