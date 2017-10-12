class AddLieuIdToUtilisateurs < ActiveRecord::Migration[5.0]
  def change
    add_column :utilisateurs, :lieu_id, :integer
  end
end
