class CreateUtilisateurs < ActiveRecord::Migration[5.0]
  def change
    create_table :utilisateurs do |t|

      t.timestamps
    end
  end
end
