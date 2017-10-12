class AddPasswordToUtilisateurs < ActiveRecord::Migration[5.0]
  def change
    add_column :utilisateurs, :password, :string
  end
end
