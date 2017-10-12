class AddMailToUtilisateurs < ActiveRecord::Migration[5.0]
  def change
    add_column :utilisateurs, :mail, :string
  end
end
