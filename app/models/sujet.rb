class Sujet < ApplicationRecord

  belongs_to :createur,
             class_name: 'Utilisateur'

  belongs_to :parent,
             class_name: 'Sujet',
             optional: true

  belongs_to :groupe

  has_and_belongs_to_many :utilisateurs,
                          class_name: 'Utilisateur',
                          join_table: 'votes'

  has_many :fils,
           class_name: 'Sujet',
           foreign_key: 'parent_id'

  has_many :commentaires

  alias_method :votants, :utilisateurs

  ####### VALIDATION ######
  validates :createur, :groupe, :titre, :description,
            :votes_blancs, :votes_contre, :votes_pour, presence: true

  after_destroy :detruit_si_groupe_vide

  ###### FONCTIONS ######
  public
  def nombre_votants
    self.votants.count
  end

  # def self.en_cours
  #   where(groupe_id: Groupe.en_cours.ids)
  # end
  #
  # def emotion(texte)
  #   texteEnglish = HTTParty.post("http://www.frengly.com/",
  #                                :query => { "src" => "fr",
  #                                            "dest" => "en",
  #                                            "text" => texte,
  #                                            "email" => "bara.julien@yahoo.fr",
  #                                            "password" => Rails.application.secrets.mot_de_passe_gmail})
  #
  #   begin
  #
  #     response = HTTParty.post("http://gateway-a.watsonplatform.net/calls/text/TextGetEmotion",
  #                              :query => { "apikey" => "b76a130b969313ddf8daeac0cce33f44757579ee",
  #                                          "text" => texteEnglish["root"]["translation"],
  #                                          "outputMode" => "json"},
  #                              :headers => { "Content-Type" => "application/x-www-form-urlencoded"})
  #
  #     if response["status"] != "ERROR"
  #       retour = Array.new
  #       retour<<response["docEmotions"]["anger"]
  #       retour<<response["docEmotions"]["disgust"]
  #       retour<<response["docEmotions"]["fear"]
  #       retour<<response["docEmotions"]["joy"]
  #       retour<<response["docEmotions"]["sadness"]
  #
  #       retour
  #     else
  #       "ERROR"
  #     end
  #
  #   rescue
  #     puts "Error #{$!}"
  #   end
  #
  # end

  def description_courte
    #sélectionne les 10 premiers mots de la chaine
    description.split[0,15].join(" ") + "..."
  end

  def victoire?
    (votes_pour > votes_contre)
  end

  def resultat_phrase
    "Ce référendum a rassemblé " + votes_pour.to_s + " votes pour, " + votes_contre.to_s + " votes contre, " + votes_blancs.to_s + " votes blancs. "
  end

  def self.search(search)
    Sujet.where("titre LIKE ?", "%#{search}%").
      or(Sujet.where("description LIKE ?", "%#{search}%"))
  end

  # private
  # def detruit_si_groupe_vide
  #   if !self.groupe.nil? && self.groupe.sujets.empty?
  #     self.groupe.destroy
  #   end
  # end

end
