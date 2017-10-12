class AddNomToCategorie < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :nom, :string
  end
end
