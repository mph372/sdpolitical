Rails.application.routes.draw do
  resources :deadlines
  get 'pages/home'
  devise_for :users, controllers: {registrations: "registrations"}
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  resources :users, only: [:index]

  resources :expenditures
  resources :elections
  resources :people
  resources :committees
  resources :measures
  resources :pricing, only: [:index]
  resources :reports
  resources :districts do
    member do
      get :follow
      get :unfollow
    end
    collection {post :import}
  end
  resources :jurisdictions
  resources :subscriptions
  resources :dashboard
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
