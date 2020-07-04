class AddCommunityToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_reference :microposts, :community, foreign_key: true
  end
end
