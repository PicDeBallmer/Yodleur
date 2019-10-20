# coding: utf-8
class CommentairesController < ApplicationController
  before_action :require_login

  def create
    @sujet = Sujet.find(params[:sujet_id])
    # pas sur de la ligne suivante ...
    auteur = utilisateur_courant
    @commentaire = @sujet.commentaires.new(commentaire_params)
    @commentaire.auteur = auteur
    @commentaire.date = Time.now

    if @commentaire.save
      redirect_to @sujet
    else
      render :new
    end
  end

  private
    def commentaire_params
      params.require(:commentaire).permit(:auteur, :texte)
    end
end
