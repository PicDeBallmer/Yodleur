class DelegationsController < ApplicationController
  before_action :require_login

  def new
    @delegation = Delegation.new
  end

  # Nouvelle délégation
  def create
    @delegation = Delegation.new(delegation_params.merge(donneur_id: utilisateur_courant.id))

    if @delegation.save
      redirect_to delegations_path
    else
      render 'new'
    end
  end

  def index

  end

  def destroy
    @delegation = Delegation.find_by_id(params[:id])

    if @delegation != nil
      @delegation.destroy
    end

    render 'index'
  end

  private
  def delegation_params
    params.require(:delegation)
        .permit(:receveur_id, :categorie_id)
  end

end
