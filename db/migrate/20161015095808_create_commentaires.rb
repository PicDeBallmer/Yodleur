class CreateCommentaires < ActiveRecord::Migration[5.0]
  def change
    create_table :commentaires do |t|

      t.timestamps
    end
  end
end
