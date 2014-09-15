Rails.application.routes.draw do
  root :to => 'user_sessions#logged_or_not'
  put 'set_current_category' => 'users#set_current_category'
  get 'home' => 'dashboard/cards#home'
  get 'login' => 'user_sessions#new'
  post 'logout' => 'user_sessions#destroy'
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
  get 'oauths/oauth'
  get 'oauths/callback'
  resources :user_sessions

  namespace :dashboard do
    resources :categories
    resources :users do
      resources :cards do
        member do
          post 'review'
        end
      end
    end
  end


end
