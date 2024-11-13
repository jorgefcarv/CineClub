Rails.application.routes.draw do
  root "filmes#index"

  resources :filmes
  resources :movie_reviews, path: 'classificacao', only: [:create, :index, :show, :edit, :update, :destroy]
  resources :home
  resources :filmes do
    member do
      get 'avaliar'
      post 'save_avaliacao'
      get 'desfavoritar', to: 'filmes#desfavoritar'
      get 'favoritar', to: 'filmes#favoritar'
    end
  end
  
  devise_for :users, controllers: { registrations: 'users' }
  
  get 'custom_logout', to: 'custom_sessions#destroy'
  get 'todos_filmes', to: 'filmes#todos_filmes'
  get 'registered_movie', to: 'filmes#registered_movie'
  get 'meus_favoritos', to: 'favorites#index', as: 'meus_favoritos'

end
