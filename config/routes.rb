Community::Application.routes.draw do
  root to: 'people#index'

  match '/auth/:provider/callback',      to: 'sessions#create'
  match '/auth/failure',                 to: 'sessions#failure'
  match '/logout' => 'sessions#destroy', as: 'logout'
  match '/auth/github',                  as: 'login'

  resources :people

  namespace :admin do
    resources :pages
  end

  match '/about', to: 'pages#show', id: 'about', as: 'about'
end
