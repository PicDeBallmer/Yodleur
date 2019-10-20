module UtilisateursHelper
  # def self.droits_egal?(cible, droit)
  #   droit[cible] == droit
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
