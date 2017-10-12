class AddNomToUtilisateurs < ActiveRecord::Migration[5.0]
  def change
    add_column :utilisateurs, :nom, :string
  end
end
