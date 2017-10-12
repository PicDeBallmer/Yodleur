class AddDateDeNaissanceToUtilisateurs < ActiveRecord::Migration[5.0]
  def change
    add_column :utilisateurs, :date_de_naissance, :datetime
  end
end
