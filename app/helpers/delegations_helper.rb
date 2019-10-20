module DelegationsHelper

  def categories_delegables
    Categorie.where.not(id: Delegation.joins(:categorie)
       .where(donneur_id: utilisateur_courant.id).pluck(:categorie_id))
  end

  def utilisateurs_delegables
    Utilisateur.where.not(id: utilisateur_courant.id)
  end

  def mes_delegations_courantes
    Delegation.where(donneur_id: utilisateur_courant.id)
  end
end
