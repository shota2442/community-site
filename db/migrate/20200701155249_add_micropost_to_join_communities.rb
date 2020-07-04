class AddMicropostToJoinCommunities < ActiveRecord::Migration[5.2]
  def change
    add_reference :join_communities, :micropost, foreign_key: true
  end
end
