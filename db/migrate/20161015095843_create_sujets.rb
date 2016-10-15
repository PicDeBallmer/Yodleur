class CreateSujets < ActiveRecord::Migration[5.0]
  def change
    create_table :sujets do |t|

      t.timestamps
    end
  end
end
