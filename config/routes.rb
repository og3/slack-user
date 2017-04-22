Rails.application.routes.draw do
  devise_for :masters, controllers: {
    registrations: 'masters/registrations', 
    confirmations: 'masters/confirmations',
    sessions: 'masters/sessions',
    passwords: 'masters/passwords',
    invitations: 'masters/invitations'
    }
  root 'masters#show'
  resources :teams, only: [:new, :create, :show] do
    resources :users, only: [:index, :new, :create]
    resources :channels, only: [:new, :create, :edit, :update, :destroy, :index] do
      resources :messages, only: [:index, :create]
    end
  end
  resources :masters, only: [:show]
  # ajax通信用のルーティング。usersコントローラーからそれぞれのuser一覧を取得する。
  get '/teams/:team_id/users' => "users#index"
end
