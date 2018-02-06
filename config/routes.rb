Rails.application.routes.draw do
  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end
  put '/wikis/:id/public', to: 'wikis#public', as: :public
  put '/wikis/:id/private', to: 'wikis#private', as: :private
  get '/my_wikis', to: 'wikis#my_wikis', as: :my_wikis

  devise_for :users

  get 'about' => 'welcome#about'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
