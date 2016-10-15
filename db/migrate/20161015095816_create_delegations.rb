class CreateDelegations < ActiveRecord::Migration[5.0]
  def change
    create_table :delegations do |t|

      t.timestamps
    end
  end
end
