class Utilisateur < ApplicationRecord
  has_secure_password

  belongs_to :lieu

  has_many :delegations_recues,
           class_name: 'Delegation',
           foreign_key: 'receveur_id'
  has_many :delegations_donnees,
           class_name: 'Delegation',
           foreign_key: 'donneur_id'
  has_many :delegations_accumulees,
           class_name: 'Delegation',
           foreign_key: 'rec_racine_id'
  has_many :categories_recues,
           class_name: 'Categorie',
           :through => :delegations_recues
  has_many :categories_donnees,
           class_name: 'Categorie',
           :through => :delegations_donnees

  has_many :sujets_crees,
           class_name: 'Sujet'

  has_and_belongs_to_many :sujets,
                          class_name: 'Sujet',
                          join_table: 'votes'

  has_many :commentaires

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :mail, presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates_presence_of :password, on: :create
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true # allow_blank pour autoriser la mise à jour (voir Aurélien pour plus d'infos, c'est une maxi magouille)

  # Image de profil
  mount_uploader :image, ImageUploader
  validate :taille_image

  validates_presence_of :nom, :prenom

  before_save {
    self.mail = mail.downcase
    :encrypt_password
  }

  def admin?
    UtilisateursHelper.droits_egal?(:admin, droits)
  end

  def pelo?
    UtilisateursHelper.droits_egal?(:pelo, droits)
  end

  def en_attente?
    UtilisateursHelper.droits_egal?(:en_attente, droits)
  end

  private
  def taille_image
    if image.size > 5.megabytes
      errors.add(:image, 'ne doit pas exéder 5Mo')
    end
  end

end
