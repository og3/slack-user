Rails.application.routes.draw do
  devise_for :masters, controllers: {
    registrations: 'masters/registrations', 
    confirmations: 'masters/confirmations',
    sessions: 'masters/sessions',
    passwords: 'masters/passwords',
    invitations: 'masters/invitations'
    }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'masters#new'
  resources :teams do
    resources :users
  end
  resources :masters
  resources :messages, only: :index
end
