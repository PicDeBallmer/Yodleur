class AddGroupeIdToSujet < ActiveRecord::Migration[5.0]
  def change
    add_column :sujets, :groupe_id, :integer
  end
end
