class CreateGroupes < ActiveRecord::Migration[5.0]
  def change
    create_table :groupes do |t|

      t.timestamps
    end
  end
end
