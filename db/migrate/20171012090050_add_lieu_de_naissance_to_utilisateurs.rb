class AddLieuDeNaissanceToUtilisateurs < ActiveRecord::Migration[5.0]
  def change
    add_column :utilisateurs, :lieu_de_naissance, :string
  end
end
