# frozen_string_literal: true

Rails.application.routes.draw do
  extend Authenticator
  scope module: "admin", path: "admin" do
    authenticate :first_run do
      get "/first-run", to: "first_run#new", as: :first_run
      post "/first-run", to: "first_run#create"
    end

    # Send to home if not available
    get "/first-run", to: redirect("/")

    get "sign_in", to: "sessions#new", as: "sign_in"
    post "sign_in", to: "sessions#create"

    authenticate :author do
      resources :sessions, only: [:index, :show, :destroy]
      resources :pages, except: [:show]
      resources :posts, except: [:show]
      resources :redirects, except: [:show]
      resources :configurations
      get "/orphans/:type", to: "orphans#index", as: "orphaned_items",
        constraints: {type: /(posts|pages)/}
      delete "/orphans/:type/:uid", to: "orphans#delete", as: "delete_orphaned_items",
        constraints: {type: /(post|page)/}
      get "/posts/close_popup", to: "posts#close_popup", as: "close_popup"
      match "/previews", to: "previews#show", via: [:patch, :post]
      get "/revisions/(:revision_type)/(:revision_model_id)", to: "revisions#show"
      post "/revisions", to: "revisions#create_for_new"
      patch "/revisions", to: "revisions#create_for_existing"
      get "/profile" => "profile#edit", :as => "edit_profile"
      patch "/profile" => "profile#update", :as => "update_profile"
      get "/account" => "account#edit", :as => "edit_account"
      patch "/account" => "account#update", :as => "update_account"
      get "/tools" => "tools#index", :as => "tools"
      get "/" => "admin#index", :as => :admin_root
    end

    get "*path", to: redirect("/admin/sign_in")
    get "/", to: redirect("/admin/sign_in")
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
