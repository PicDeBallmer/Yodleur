class Utilisateur < ApplicationRecord
  has_secure_password

  belongs_to :lieu
  has_many :delegations_recues,
           class_name: 'Delegation',
           foreign_key: 'receveur_id'
  has_many :delegations_donnees,
           class_name: 'Delegation',
           foreign_key: 'donneur_id'
  has_many :delegueurs,
           # class_name: 'Utilisateur',
           :through => :delegations_recues,
           :source => :receveur
  has_many :delegues,
           # class_name: 'Utilisateur',
           :through => :delegations_donnees,
           :source => :donneur
  has_many :sujets_crees,
           class_name: 'Sujet'
  has_many :commentaires
  has_and_belongs_to_many :sujets,
                          class_name: 'Sujet',
                          join_table: 'votes'

  validates_presence_of :nom, :prenom
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_presence_of :mail,
                        length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
  validates_length_of :password, :minimum => 8, on: :create

  # Image de profil
  mount_uploader :image, ImageUploader
  validate :verification_taille_image

  before_validation :before_validation

  enum droit: [:citoyen, :elu, :administrateur, :en_attente ]

  def nom_complet
    [prenom.to_s, nom.upcase.to_s].delete_if{ |s| s.empty? }.join(' ')
  end

  # Est-ce que l'utisateur a donné son vote pour la +categorie+
  def delegation_donnee? categorie_id
    self.delegations_donnees.exists?(categorie_id: categorie_id)
  end

  # Nombre de votes possédés par l'utilisateur pour la +catégorie+
  # 1 + le nombre de votes en plus recues
  def votes_disponibles_par_categorie categorie_id
    delegations_par_categorie(categorie_id).
        inject(1) { |somme, delegation | somme + delegation.donneur.votes_disponibles_par_categorie(categorie_id) }
  end

  # Les utilisateurs qui ont donné leur vote directement à +self+
  def delegations_par_categorie categorie_id
    if delegations_recues.where(categorie_id: categorie_id).count == 0
      []
    else
      delegations_recues.where(categorie_id: categorie_id)
    end
  end

  def self.search(search)
    Utilisateur.where("lower(nom) LIKE ?", "%#{search.downcase}%")
      .or(Utilisateur.where("lower(prenom) LIKE ?", "%#{search.downcase}%"))
      .or(Utilisateur.where("lower(mail) LIKE ?", "%#{search.downcase}%"))
      .or(Utilisateur.where("lower(concat_ws(' ', prenom, nom)) LIKE ?", "%#{search.downcase}%"))
      .or(Utilisateur.where("lower(concat_ws(' ', nom, prenom)) LIKE ?", "%#{search.downcase}%"))
  end

  private
  def verification_taille_image
    if image.size > 5.megabytes
      errors.add(:image, 'ne doit pas exéder 5Mo')
    end
  end

  def before_validation
    self.mail = mail.downcase
  end
end
