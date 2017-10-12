class Lieu < ApplicationRecord

  has_many :utilisateurs
  has_many :sujets

  validates :nom, presence: true, length: { minimum: 2, maximum: 50 }

end
