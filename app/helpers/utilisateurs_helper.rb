module UtilisateursHelper

  # def self.droits
  #   {
  #       :pelo => 0, # pélo = citoyen normal
  #       :elu => 1,
  #       :admin => 2,
  #       :en_attente => 3
  #   }
  # end

  def self.droits_egal?(cible, droit)
    droits[cible] == droit
  end

  def tous_delegueurs
    delegations_recues.collect{|d| {donneur: d.donneur, categorie: d.categorie}}
  end

  def tous_delegues
    delegations_donnees.collect{|d| {receveur: d.receveur, categorie: d.categorie}}
  end

  # def self.droits_select
  #   # Convertit la liste de droits dans la format [[:pelo, 0], ...]
  #   # Utilisé pour les <select>
  #   droits.to_a
  # end

  def self.civilites
    {
        0 => '',
        1 => 'M.',
        2 => 'Mme'
    }
  end

  def self.civilites_select
    # Convertit la liste de civilités dans le format [["", 0], ...].
    # Utilisé pour les <select>
    civilites.to_a.collect { |l| l.reverse }
  end

end
