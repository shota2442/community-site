class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.string :content
      t.references :user, type: :bigint, foreign_key: true
      t.references :community, type: :bigint, foreign_key: true

      t.timestamps
    end
  end
end
