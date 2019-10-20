class SessionsController < ApplicationController
  before_action :require_no_login, only: [:new, :create]

  def new
  end

  def create
    utilisateur = Utilisateur.find_by_mail(params[:mail].downcase)
    if utilisateur && utilisateur.en_attente?
      flash[:erreur] = 'Votre compte n\'a pas encore été validé par votre mairie'
      render 'new'
    else
      if utilisateur && utilisateur.authenticate(params[:mot_de_passe])
        log_in utilisateur
        redirect_to root_path
      else
        flash[:erreur] = 'Courriel ou mot de passe invalide'
        render 'new'
      end
    end

  end

  def destroy
    log_out
    redirect_to root_path, :notice => 'Logged out!'
  end

end
