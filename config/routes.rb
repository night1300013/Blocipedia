Rails.application.routes.draw do
  resources :wikis
  get '/wikis/:id/public', to: 'wikis#public', as: :public
  get '/wikis/:id/private', to: 'wikis#private', as: :private

  devise_for :users

  get 'about' => 'welcome#about'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
