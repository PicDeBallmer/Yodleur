Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  default_url_options :host => "localhost:3000"
  root 'pages#accueil'

  # menu
  get '/accueil' => 'pages#accueil'
  get '/proposer'  => 'groupes#new'
  get '/mes_propositions'  => 'groupes#index_mygroups'
  get '/voter' => 'groupes#index'
  get '/resultats' => 'groupes#index_outdated'
  get '/liste_utilisateurs' => 'utilisateurs#index'
  get '/a_propos' => 'pages#a_propos'
  

end
