class AddTitreIdToSujet < ActiveRecord::Migration[5.0]
  def change
    add_column :sujets, :titre, :string
  end
end
