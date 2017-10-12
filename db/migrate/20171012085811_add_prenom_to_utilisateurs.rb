class AddPrenomToUtilisateurs < ActiveRecord::Migration[5.0]
  def change
    add_column :utilisateurs, :prenom, :string
  end
end
