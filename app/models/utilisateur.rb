class Utilisateur < ApplicationRecord

  def pelo?
    UtilisateursHelper.droits_egal?(:pelo, droits)
  end

end
