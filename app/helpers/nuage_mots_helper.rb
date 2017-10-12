module NuageMotsHelper
  # Renvoie une liste [{mot, lien, poids}] pour le nuage de mots
  def liste_mots_pour_nuage
    # MotNuage.all
    [MotNuage.new({mot: "Barbiche", poids: "20"}),
     MotNuage.new({mot: "INSA", poids: "10"})]
  end
end
