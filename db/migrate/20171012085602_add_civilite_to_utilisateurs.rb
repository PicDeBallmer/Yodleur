class AddCiviliteToUtilisateurs < ActiveRecord::Migration[5.0]
  def change
    add_column :utilisateurs, :civilite, :string
  end
end
