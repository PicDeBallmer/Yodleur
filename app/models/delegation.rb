class Delegation < ApplicationRecord
  # before_create :creation
  # before_destroy :suppression

  belongs_to :donneur,
             class_name: 'Utilisateur'
  belongs_to :receveur,
             class_name: 'Utilisateur'
  # belongs_to :rec_racine,
  #            class_name: 'Utilisateur'
  belongs_to :categorie

  validates :donneur_id, presence: true
  validates :categorie_id, presence: true, uniqueness: {scope: :donneur_id}
  validates :receveur_id, presence: true
  # TODO: différence entre le donneur et receveur

  validate :validation_cycle

  private
  def validation_cycle
    if donneur_id == receveur_id
      errors.add(:receveur_id, ' ne peut pas être le donneur')
    end

    if Utilisateur.find_by_id(donneur_id).delegueurs_par_categorie(categorie_id).exists?(receveur_id)
      errors.add(:receveur_id, ' a déjà donné son vote (directement ou non) au donneur')
    end
  end

  # Delegation.create(categorie_id: 1, donneur_id: 4, receveur_id: 3)
  # private
  # def creation
  #   delegation_du_receveur = receveur.delegations_donnees.find_by(categorie_id: categorie_id)
  #   if delegation_du_receveur.nil?
  #     # Le receveur n'a pas donné de délégation pour cette catégorie
  #     # Il devient donc la racine du sous-arbre du donneur
  #     self.rec_racine = receveur
  #     self.rec_profondeur = 1
  #   else
  #     # Le receveur a donné une délégation pour cette catégorie
  #     # La racine de son sous-arbre devient la racine du sous-arbre du donneur
  #     self.rec_racine = delegation_du_receveur.rec_racine
  #     self.rec_profondeur = delegation_du_receveur.rec_profondeur + 1
  #   end
  #
  #   # Mise à jour du sous-arbre du donneur
  #   donneur.delegations_accumulees.where(categorie_id: categorie_id)
  #       .update_all("rec_profondeur = rec_profondeur + #{rec_profondeur},
  #                                             rec_racine_id = #{rec_racine_id}")
  # end

  # Delegation.find_by(categorie_id: 2, donneur_id: 3).destroy
  # private
  # def suppression
  #   # Le sous-arbre du donneur (profondeur > lien coupé) est modifié :
  #   # profondeur -= profondeur du lien, racine = donneur du lien
  #   rec_racine.delegations_accumulees.where(categorie_id: categorie_id)
  #       .where('rec_profondeur > ?', rec_profondeur)
  #       .update_all("rec_profondeur = rec_profondeur - #{rec_profondeur},
  #                                             rec_racine_id = #{donneur_id}")
  # end
end
