class AddMotToMotNuage < ActiveRecord::Migration[5.0]
  def change
    add_column :mot_nuages, :mot, :string
  end
end
