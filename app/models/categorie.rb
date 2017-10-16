class Categorie < ApplicationRecord

  # has_many :delegations_donnees
  # # has_many :donneurs,
  # #          :through => :delegations,
  # #          foreign_key: 'donneur_id'
  # # has_many :receveurs,
  # #          :through => :delegations
  #
  # has_many :sujets_principaux,
  #          class_name: 'Sujet',
  #          foreign_key: 'categorie_principale_id'
  # has_many :sujets_secondaires,
  #          class_name: 'Sujet',
  #          foreign_key: 'categorie_secondaire_id'

  validates_presence_of :nom

  # Si le texte correspond au nom de la catégorie exact
  def self.search(texte)
    where("lower(nom) LIKE ?", "%#{texte.downcase}%")
  end

end
