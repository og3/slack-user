Rails.application.routes.draw do
  devise_for :masters, controllers: {
    registrations: 'masters/registrations', 
    confirmations: 'masters/confirmations',
    sessions: 'masters/sessions',
    passwords: 'masters/passwords',
    invitations: 'masters/invitations'
    }
  root 'masters#show'
  resources :teams do
    resources :users
    resources :channels, only: [:new, :create, :edit, :update] do
      resources :messages
    end
  end
  resources :masters
  get '/teams/:team_id/users' => "users#index"
  
end
