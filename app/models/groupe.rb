class Groupe < ApplicationRecord

  has_many :sujets, :dependent => :delete_all

  belongs_to :categorie_principale,
             class_name: 'Categorie'
  belongs_to :categorie_secondaire,
             class_name: 'Categorie',
             optional: true
  belongs_to :lieu

  validates_presence_of :categorie_principale

  # Recherche de tous les groupes dont les sujets ou les catégories sont en rapport
  def self.search(search)
    sujets_groupe_ids = Sujet.search(search).select("groupe_id")
    categories_ids = Categorie.search(search).ids
    Groupe.where(:id => sujets_groupe_ids)
    .or(Groupe.where(:categorie_principale_id => categories_ids))
    .or(Groupe.where(:categorie_secondaire_id => categories_ids))
  end

  def votes_total
    self.sujets.inject(0) do |total, sujet|
      total + sujet.nombre_votants
    end
  end

  def createur
    self.sujets.first.createur
  end

  # def en_cours?
  #   DateTime.now.between? self.date_debut, self.date_fin
  # end

  # def self.en_cours
  #   where{(date_debut <= DateTime.now) & (date_fin >= DateTime.now)}
  # end

  # def pourcentage_restant
  #   termine = date_fin - date_debut
  #   en_cours = (Time.current - date_debut)
  #   pourcentage = 100 - ((en_cours * 100) / termine).to_i
  #   if pourcentage > 100
  #     pourcentage = 100
  #   elsif pourcentage < 0
  #     pourcentage = 0
  #   end
  #   pourcentage
  # end

  def temps_restant
    t = (self.date_fin - Time.current).to_i
    if t<0
      'Vote terminé !'
    else
      mm, ss = t.divmod(60)
      hh, mm = mm.divmod(60)
      dd, hh = hh.divmod(24)
      "%d jours, %d heures, %d minutes" % [dd, hh, mm]
    end
  end

  # def termine?
  #   date_fin < Time.current
  # end

  def description_courte
    self.sujets.first.description_courte
  end

  def victoire?
    self.sujets.first.victoire?
  end

  def resultat_phrase
    self.sujets.first.resultat_phrase
  end

end
