class Commentaire < ApplicationRecord
  #TODO: linker les + - avec les users

  belongs_to :sujet
  belongs_to :auteur,
             class_name: 'Utilisateur'
  belongs_to :parent,
             class_name: 'Commentaire',
             optional: true
  has_many :reponses,
           class_name: 'Commentaire',
           foreign_key: 'parent_id'
end
