class AddDroitsToUtilisateurs < ActiveRecord::Migration[5.0]
  def change
    add_column :utilisateurs, :droits, :integer
  end
end
