Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users, controllers: {registrations: "registrations"}
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  resources :users, only: [:index]
  resources :expenditures
  resources :elections
  resources :people
  resources :committees
  resources :measures
  resources :dashboard, only: [:index]
  resources :pricing, only: [:index]
  resources :reports
  resources :districts do
    member do
      put "add", to:"districts#dashboard"
      put "remove", to:"districts#dashboard"
    end
    collection {post :import}
  end
  resources :jurisdictions
  resources :subscriptions
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
