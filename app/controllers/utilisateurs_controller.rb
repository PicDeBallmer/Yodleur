class UtilisateursController < ApplicationController
  include UtilisateursHelper

  def index
    @utilisateurs = Utilisateur.all
    if params[:search]
      @utilisateurs = Utilisateur.search(params[:search]).order('created_at DESC')
    else
      @utilisateurs = Utilisateur.order('created_at DESC')
    end
  end

  def show
    @utilisateur = Utilisateur.find_by_id(params[:id])
    @tous_delegues = tous_delegues(@utilisateur)
    @tous_delegueurs = tous_delegueurs(@utilisateur)
  end

  def new
    @utilisateur = Utilisateur.new
  end

  def edit
    @utilisateur = Utilisateur.find_by_id(params[:id])

    if @utilisateur.admin?
      @liste_droits = droits_select(@utilisateur)
    end

    if !utilisateur_courant_ou_admin?(@utilisateur)
      forbidden
    end
  end

  def create
    @utilisateur = Utilisateur.new(utilisateur_params)

    # Si production : On envoie le mail à la mairie, on attend le retour, etc.
    # Si développement : On inscrit le pélo automatiquement
    if Rails.env == 'production'
      @utilisateur.droit = "en_attente"
    elsif Rails.env == 'development'
      @utilisateur.droit = Utilisateur.any? ? "pelo" : "admin"
    end

    if @utilisateur.save
      # Si production : email de bienvenue
      if Rails.env == 'production'
        UtilisateurMailer.welcome_email(@utilisateur).deliver_now
        UtilisateurMailer.verif_mairie(@utilisateur).deliver_now
      end

      # log_in @utilisateur # Connexion automatique à l'inscription
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @utilisateur = Utilisateur.find_by_id(params[:id])

    # Interdit si l'utilisateur essaye de mettre à jour des droit sans être administrateur...
    if params.include? :droit && !utilisateur_courant.admin?
      forbidden
    end

    lieu = Lieu.find_by_id(params[:utilisateur][:lieu_id])
    @utilisateur.lieu = lieu

    if @utilisateur.update(utilisateur_params)
      redirect_to @utilisateur
    else
      render 'edit'
    end
  end

  # def verifier_mairie
  #   @utilisateur = Utilisateur.find_by_id(params[:id])
  #   if params[:cle].to_i == @utilisateur.generer_cle
  #
  #     # Le premier utilisateur créé est administrateur
  #     #@utilisateur.droit = Utilisateur.any? ? UtilisateursHelper.droit[:pelo] : UtilisateursHelper.droit[:admin]
  #     Utilisateur.update(@utilisateur.id, droit: Utilisateur.any? ? UtilisateursHelper.droit[:pelo] : UtilisateursHelper.droit[:admin])
  #     UtilisateurMailer.verif_mairie_reussie(@utilisateur).deliver_now
  #   else
  #     forbidden
  #   end
  # end

  private
  def utilisateur_params
    params.require(:utilisateur).permit(
        :civilite,
        :prenom,
        :nom,
        :date_de_naissance,
        :mail,
        :lieu_de_naissance,
        :lieu_id,
        :image,
        :password,
        :password_confirmation,
        :droit
    )
  end

end
