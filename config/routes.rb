Rails.application.routes.draw do
  # Devise routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { registrations: "registrations", confirmations: 'confirmations' }

  # ActiveAdmin routes
  ActiveAdmin.routes(self)

  # Stripe routes
  mount StripeEvent::Engine, at: '/stripe-webhooks'

  # Resource routes
  resources :vendors
  resources :transactions, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    collection { post :import }
  end
  resources :campaign_finance_modules
  resources :candidate_committees
  resources :candidates
  resources :former_offices
  resources :registration_snapshots do
    collection { post :import }
  end
  resources :statistical_data
  resources :historical_candidates
  resources :election_histories
  resources :updates
  resources :elections
  resources :people do 
    resources :reports, only: [:index]
    member do
      get 'archive'
    end
  end
  resources :campaigns
  resources :campaign_candidates
  resources :pricing, only: [:index]
  resources :reports
  resources :districts do
    member do
      get :follow
      get :unfollow
    end
    collection { post :import }
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
  resources :users, only: [:index, :destroy]

  # Custom routes
  get 'emails/unsubscribe'
  get :search, controller: :main
  match "users/unsubscribe/:unsubscribe_hash" => "emails#unsubscribe", as: "unsubscribe", via: :all
  match 'users/:id' => 'users#destroy', via: :delete, as: :admin_destroy_user

  # Root path
  root 'pages#home'

  # Additional information
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
