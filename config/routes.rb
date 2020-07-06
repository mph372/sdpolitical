Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'pages/home'
  devise_for :users, controllers: {registrations: "registrations"}
  resources :expenditures
  resources :elections
  resources :people
  resources :committees
  resources :measures
  resources :tracker, only: [:index]
  resources :pricing, only: [:index]
  resources :reports
  resources :districts do
    member do
      put "add", to:"districts#tracker"
      put "remove", to:"districts#tracker"
    end
    collection {post :import}
  end
  resources :jurisdictions
  resources :subscriptions
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
