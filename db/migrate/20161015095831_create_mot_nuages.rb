class CreateMotNuages < ActiveRecord::Migration[5.0]
  def change
    create_table :mot_nuages do |t|

      t.timestamps
    end
  end
end
