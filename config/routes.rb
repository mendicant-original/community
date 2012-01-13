Community::Application.routes.draw do
  root to: 'articles#index'

  match '/auth/:provider/callback',      to: 'sessions#create'
  match '/auth/failure',                 to: 'sessions#failure'
  match '/logout' => 'sessions#destroy', as: 'logout'
  match '/auth/github',                  as: 'login'

  resources :people
  resources :articles
  resources :activities do
    member do
      post :register
    end
  end

  namespace :admin do
    resources :pages
  end

  match '/about', to: 'pages#show', id: 'about', as: 'about'
end
