Rails.application.routes.draw do
  namespace :staff do
    root 'top#index'
    get "login" => "sessions#new", as: :login
    resource :session, only: [ :create, :destroy ]
    resource :account
  end
  namespace :admin do
    root 'top#index'
    get "login" => "sessions#new", as: :login
    post "session" => "sessions#create", as: :session
    delete "session" => "sessions#destroy"
    resources :staff_members
  end
  namespace :customer do
    root 'top#index'
  end
end
