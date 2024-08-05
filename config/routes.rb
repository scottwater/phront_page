# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: "admin", path: "admin" do
    get "/first-run", to: "first_run#new", as: :first_run
    post "/first-run", to: "first_run#create"
    get "sign_in", to: "sessions#new"
    post "sign_in", to: "sessions#create"
    resources :sessions, only: [:index, :show, :destroy]
    resources :pages, except: [:show]
    resources :posts, except: [:show]
    resources :redirects, except: [:show]
    resources :configurations
    match "/previews", to: "previews#show", via: [:patch, :post]
    get "/profile" => "profile#edit", :as => "edit_profile"
    patch "/profile" => "profile#update", :as => "update_profile"
    get "/account" => "account#edit", :as => "edit_account"
    patch "/account" => "account#update", :as => "update_account"

    get "/" => "admin#index", :as => :admin_root
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", :as => :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", :as => :pwa_manifest
  get "feed", to: "feed#index", defaults: {format: :json}
  get "*slug" => "blog#show", :as => :blog_show, :constraints => lambda { |req|
                                                                   !req.path.match?(%r{^(/rails/|/blobs/)})
                                                                 }
  root "blog#show"
end
