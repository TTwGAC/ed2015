Gac2014::Application.routes.draw do
  resources :messages do
    post '/send', to: 'messages#send_message', as: 'send'
  end

  resources :penalties


  get '/game' => 'game#show'
  get '/game/edit' => 'game#edit'
  put '/game' => 'game#update'
  patch '/game' => 'game#update'

  get '/dashboard' => 'dashboard#show'


  resources :documents


  resources :clusters


  resources :puzzles do
    resources :documents
    resources :hints
  end


  resources :locations do
    resources :documents
    get :posters
  end


  resources :checkins


  resources :join_attempts, only: [:index, :new, :create]
  delete '/join_attempts' => 'join_attempts#destroy'

  resources :team_invitations, only: [:index, :new, :create, :destroy]
  resources :teams

  devise_for :players, :controllers => {
                         :omniauth_callbacks => "players/omniauth_callbacks",
                         :registrations => "players/registrations"
                       }
  resources :players

  resources :events

  get '/redirect/:token' => 'redirect#show'
  resources :redirects


  root :to => 'home#index'

end
