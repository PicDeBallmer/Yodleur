class AddDescriptionToSujet < ActiveRecord::Migration[5.0]
  def change
    add_column :sujets, :description, :string
  end
end
