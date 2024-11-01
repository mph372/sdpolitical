Rails.application.routes.draw do
  get 'contests/show'

  # Devise routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { registrations: "registrations", confirmations: 'confirmations' }

  # ActiveAdmin routes
  ActiveAdmin.routes(self)



  # Resource routes


  resources :campaign_finance_modules
  resources :candidate_committees do
    resources :reports
  end
  resources :candidates
  resources :former_offices
  resources :registration_snapshots do
    collection { post :import }
  end
  resources :statistical_data
  resources :historical_candidates
  resources :election_histories
  resources :updates
  
  resources :people do 
    resources :reports, only: [:index]
    
    member do
      get 'archive'
    end
  
    collection do
      get 'search'
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
      patch :toggle_archive
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
  resources :blog_posts
  get 'tags/:tag_name', to: 'blog_posts#index', as: :filter_by_tag
  get 'navigate_jurisdiction', to: 'jurisdictions#navigate', as: :navigate_jurisdiction
  resources :elections, param: :slug do
    member do
      post 'process_results_update'
    end
    
    resources :election_updates
    resources :contests, only: [:show] do
      member do
        post 'pin', to: 'pinned_contests#create'
        delete 'unpin', to: 'pinned_contests#destroy'
      end
    end
    resources :uploads, only: [:create]
  end

  



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
