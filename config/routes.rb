Rails.application.routes.draw do
  resources :wikis
  put '/wikis/:id/public', to: 'wikis#public', as: :public
  put '/wikis/:id/private', to: 'wikis#private', as: :private
  get '/my_wikis', to: 'wikis#my_wikis', as: :my_wikis
  resources :charges, only: [:new, :create]
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: "users/registrations" }
  devise_scope :user do
    get 'downgrade', to: 'users/registrations#downgrade'
    get 'upgrade', to: 'users/registrations#upgrade'
  end
  
  get 'about' => 'welcome#about'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
