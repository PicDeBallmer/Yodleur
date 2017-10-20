# coding: utf-8
class SujetsController < ApplicationController
  before_action :require_login, except: :show
  before_action :require_admin, only: :destroy

  def show
    @sujet = Sujet.find_by_id(params[:id])
    if @sujet.nil?
      redirect_to root_path
    end
    
    commentaires = ""
    
    @sujet.commentaires.each do |com|
      commentaires = commentaires + com.texte + " "
    end
    
    if commentaires != ""
      retour = @sujet.emotion(commentaires)
    else
      retour = "ERROR"
    end
    
    if retour != "ERROR"
      @Colere = retour[0]
      @Degout = retour[1]
      @Peur = retour[2]
      @Joie = retour[3]
      @Tristesse = retour[4]
    else
      @Colere = "ERROR"
      @Degout = "ERROR"
      @Peur = "ERROR"
      @Joie = "ERROR"
      @Tristesse = "ERROR"
    end
  end

  def new
    @sujet = Sujet.new
    @sujet_parent = Sujet.find_by_id(params[:parent_id])
    if @sujet_parent.nil?
      redirect_to groupes_url, notice: 'Sujet parent non-existant'
    end
  end

  def create
    @sujet = Sujet.new(sujet_params)
    @sujet_parent = Sujet.find_by_id(@sujet.parent_id)

    if @sujet_parent.nil?
      redirect_to groupes_url, notice: 'Sujet parent non-existant'
    else
      @sujet.groupe_id = @sujet_parent.groupe_id

      if @sujet.save
        redirect_to @sujet, notice: 'Le sujet a été créé.'
      else
        render 'new'
      end
    end
  end

  def destroy
    @sujet = Sujet.find_by_id(params[:id])
    if @sujet.nil?
      redirect_to :groupes
    else
      @sujet.destroy
      redirect_to @sujet.groupe, notice: 'Sujet supprimé'
    end
  end

  def incremente_votes_pour
    incremente_votes(:votes_pour)
  end

  def incremente_votes_contre
    incremente_votes(:votes_contre)
  end

  def incremente_votes_blancs
    incremente_votes(:votes_blancs)
  end
  
  private
    def incremente_votes(type_vote)
      @sujet = Sujet.find_by_id(params[:id])
      if @sujet.nil?
        redirect_to root_path
      else
        cat_id = @sujet.groupe.categorie_principale_id
        @sujet.update_attributes(type_vote => @sujet[type_vote] +
            utilisateur_courant.votes_disponibles_par_categorie(cat_id))
        @sujet.votants.append(utilisateur_courant.delegueurs_et_moi(cat_id))
        render 'show'
      end
    end

    def sujet_params
      params.require(:sujet).permit(:titre, :description, :parent_id).merge(
            votes_blancs: 0, votes_pour: 0, votes_contre: 0, createur_id: utilisateur_courant.id
      )
    end
end
