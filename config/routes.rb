Rails.application.routes.draw do
  resources :vendors
  resources :contributors
  resources :imports
  resources :transactions do
    collection { post :import }
  end
  resources :county_transactions
  resources :city_sd_transactions
  resources :itemized_expenditures
  resources :campaign_finance_modules
  resources :admins
  resources :candidate_committees
  resources :candidates
  resources :former_offices
  resources :registration_snapshots
  resources :statistical_data
  resources :historical_candidates
  resources :election_histories
  mount StripeEvent::Engine, at: '/stripe-webhooks'
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
  resources :people do 
    resources :reports, only:
    [:index]
    member do
      get 'archive'
    end
  end
  resources :committees
  resources :campaigns
  resources :campaign_candidates
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
  resources :jurisdictions do
    member do
      get 'make_archived'
      get 'unarchive'
    end
  end
  resources :subscriptions
  resources :dashboard
  resources :help
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
  post 'contributor/cleanup'
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
