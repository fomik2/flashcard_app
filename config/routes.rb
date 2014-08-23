Rails.application.routes.draw do
  root :to => 'welcome#logged_or_not'
  put 'set_current_category' => 'users#set_current_category'
  get 'welcome' => 'welcome#index'
  get 'login' => 'user_sessions#new'
  post 'logout' => 'user_sessions#destroy'
  resources :categories 
  resources :user_sessions
  resources :users do
    resources :cards do
      member do
        post 'review'
      end
    end
  end
   
end
