Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  default_url_options :host => "localhost:3000"
  root 'pages#accueil'

  # menu
  get '/accueil'            => 'pages#accueil'
  get '/a_propos'           => 'pages#a_propos'
  get '/proposer'           => 'groupes#new'
  get '/mes_propositions'   => 'groupes#index_mygroups'
  get '/voter'              => 'groupes#index'
  get '/resultats'          => 'groupes#index_outdated'
  get '/liste_utilisateurs' => 'utilisateurs#index'

  # ressources
  resources :mot_nuages
  resources :utilisateurs
  resources :delegations
  resources :sessions
  resources :groupes
  resources :lieux
  resources :categories
  resources :sujets do
    resources :commentaires
  end
  
  # session
  get 'sessions/new'
  get 'log_out' => 'sessions#destroy', :as => 'log_out'
  get 'log_in' => 'sessions#new', :as => 'log_in'
  get 'sign_up' => 'utilisateurs#new', :as => 'sign_up'

  # administration
  get 'admin' => 'admin#index'

  # routes de sujet
  get '/ammendements/:id/new' => 'sujets#nouvel_ammendement', as: :nouvel_ammendement
  post '/ammendements' => 'sujets#creer_ammendement', as: :creer_ammendement

  patch '/sujets/:id/incremente_votes_pour' => 'sujets#incremente_votes_pour', as: :incremente_votes_pour
  patch '/sujets/:id/incremente_votes_contre' => 'sujets#incremente_votes_contre', as: :incremente_votes_contre
  patch '/sujets/:id/incremente_votes_blancs' => 'sujets#incremente_votes_blancs', as: :increase_votes_blancs

  # graphe
  get 'groupes/:id/graphe' => 'groupes#graphe', :as => 'graphe'

end
