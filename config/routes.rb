Community::Application.routes.draw do
  root to: 'articles#index'

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure'            => 'sessions#failure'
  match '/logout'                  => 'sessions#destroy', as: 'logout'

  match '/read_all/:type' => 'people#read_all', as: 'read_all'

  resources :people
  resources :articles
  resources :activities do
    member do
      post :register
      post :archive
      post :restore
      post :create_discussion_list
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
