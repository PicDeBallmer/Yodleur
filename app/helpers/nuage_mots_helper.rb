module NuageMotsHelper
  # Renvoie une liste [{mot, lien, poids}] pour le nuage de mots
  def liste_mots_pour_nuage
    MotNuage.all
  end
end
