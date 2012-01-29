Community::Application.routes.draw do
  root to: 'articles#index'

  match '/auth/:provider/callback',      to: 'sessions#create'
  match '/auth/failure',                 to: 'sessions#failure'
  match '/logout' => 'sessions#destroy', as: 'logout'

  resources :people
  resources :articles
  resources :activities do
    member do
      post :register
      post :archive
      post :restore
    end
    collection do
      get :archived
    end
  end

  namespace :admin do
    resources :pages
  end

  match '/about',     to: 'pages#show', id: 'about', as: 'about'
  match '/pages/:id', to: 'pages#show', as: 'page'
end
