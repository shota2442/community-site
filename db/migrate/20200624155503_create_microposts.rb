class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :community, foreign_key: true

      t.timestamps
      
    end
  end
end
