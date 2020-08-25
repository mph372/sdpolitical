Rails.application.routes.draw do
  get 'emails/unsubscribe'
  resources :registration_histories
  resources :updates
  resources :deadlines
  get 'pages/home'
  devise_for :users, controllers: {registrations: "registrations", confirmations: 'confirmations'}
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  match "users/unsubscribe/:unsubscribe_hash" => "emails#unsubscribe", as: "unsubscribe", via: :all
  
  unauthenticated :user do
    root 'pages#home', as: :unauthenticated_root
  end
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  resources :users, only: [:index]
  get :search, controller: :main
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
