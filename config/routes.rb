Community::Application.routes.draw do
  root to: 'landing#index'

  match '/auth/:provider/callback',      to: 'sessions#create'
  match '/auth/failure',                 to: 'sessions#failure'
  match '/logout' => 'sessions#destroy', as: 'logout'
  match '/auth/github',                  as: 'login'

  resources :people
end
