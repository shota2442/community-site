class CreateCommunityMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :community_microposts do |t|
      t.references :micropost, foreign_key: true
      t.references :community, foreign_key: true

      t.timestamps
      
      t.index [:micropost_id, :community_id], unique: true
    end
  end
end
