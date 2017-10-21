class GroupesController < ApplicationController

  before_action :require_login, only: [:new, :edit, :create]
  before_action :require_admin, only: :destroy

  # respond_to :html, :json

  # GET /groupes
  def index
    if params[:search]
      @groupes = Groupe.search(params[:search]).order(created_at: :desc)
    else
      @groupes = Groupe.order(created_at: :desc)
    end
    @titre_liste1 = 'Référendums institutionnels'
    @titre_liste2 = 'Référendums citoyens'
    @groupes_institutionnels = @groupes.select { |groupe| groupe.date_fin > DateTime.now && !groupe.createur.citoyen? }
    @groupes_citoyens = @groupes.select { |groupe| groupe.date_fin > DateTime.now && groupe.createur.citoyen? }
  end

  def index_outdated
    if params[:search]
      @groupes = Groupe.search(params[:search]).order(created_at: :desc)
    else
      @groupes = Groupe.order(created_at: :desc)
    end
    @titre_liste1 = 'Référendum institutionnel outdated'
    #@condition1 = <% if groupe.date_fin > DateTime.now +  (2/24.0) && !groupe.createur.citoyen? %>
    @titre_liste2 = 'Référendum citoyen outdated'
    #@condition2 = <% if groupe.date_fin > DateTime.now +  (2/24.0) && groupe.createur.citoyen? %>
    @groupes_institutionnels = @groupes.select { |groupe| groupe.date_fin > DateTime.now && !groupe.createur.citoyen? }
    @groupes_citoyens = @groupes.select { |groupe| groupe.date_fin > DateTime.now && groupe.createur.citoyen? }
  end

  def index_mygroups
    if params[:search]
      @groupes = Groupe.search(params[:search]).order(created_at: :desc)
    else
      @groupes = Groupe.order(created_at: :desc)
    end
    @titre_liste1 = 'Référendums en cours'
    #@condition1 = <% if groupe.createur == utilisateur_courant && groupe.date_fin > DateTime.now + (2/24.0) %>
    @titre_liste2 = 'Référendums terminés'
    #@condition2 = <% if groupe.createur == utilisateur_courant && groupe.date_fin <  DateTime.now +  (2/24.0) %>
  end

  # GET /groupes/1
  def show
    @groupe = Groupe.find_by_id(params[:id])
  end

  # GET /groupes/new
  def new
    @groupe = Groupe.new
    @sujet = Sujet.new
    # redirect_to controller: sujets_url, action: new #, :titre => titre
    # redirect_to use_route: 'sujets/new'
  end
  # POST /groupes
  def create
    @groupe = Groupe.new(groupe_params)
    @sujet = Sujet.new(sujet_params)
    if @groupe.save
      @sujet.createur = utilisateur_courant
      @sujet.votes_pour = 0
      @sujet.votes_blancs = 0
      @sujet.votes_contre = 0
      @sujet.groupe = @groupe
      @sujet.titre = @groupe.titre
      if @sujet.save
        redirect_to @groupe, notice: 'Groupe was successfully created.'
      else
        @groupe.destroy
        render :new
      end
    else
      render :new
    end
  end

  # GET /groupes/1/edit
  # def edit
  # end

  # def destroy
  #   groupe = Groupe.find_by_id(params[:id])
  #   unless groupe.nil?
  #     groupe.destroy
  #   end
  #   redirect_to :groupes
  # end

  # def graphe
  #   @groupe = Groupe.find(params[:id])
  #   respond_to do |format|
  #     format.json {
  #
  #       nodes = @groupe.sujets
  #       links = nodes.select {|node| !node.parent.nil?}.collect do |node|
  #         {
  #             source: nodes.index(node),
  #             target: nodes.index(node.parent)
  #         }
  #       end
  #
  #       render json: {
  #           nodes: nodes,
  #           links: links
  #       }
  #     }
  #   end
  # end

  private
  def groupe_params
    params.require(:groupe).permit(
      :titre,
      :lieu_id,
      :date_debut,
      :date_fin,
      :categorie_principale_id,
      :categorie_secondaire_id)
  end

  def sujet_params
    params.require(:sujet).permit(:description)
  end

end
