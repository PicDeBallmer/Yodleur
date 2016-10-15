class AddPoidsToMotNuage < ActiveRecord::Migration[5.0]
  def change
    add_column :mot_nuages, :poids, :integer
  end
end
