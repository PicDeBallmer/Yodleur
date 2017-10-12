class Utilisateur < ApplicationRecord

  attr_accessor :civilite
  attr_accessor :prenom
  attr_accessor :nom
  attr_accessor :date_de_naissance
  attr_accessor :lieu_de_naissance
  attr_accessor :lieu_id
  attr_accessor :mail
  attr_accessor :password
  attr_accessor :password_confirmation
  attr_accessor :droits

end
