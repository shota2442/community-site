class JoinCommunitiesController < ApplicationController
  def create
    community = Community.find(params[:community_id])
    current_user.join_community(community)
    flash[:success] = 'コミュニティに参加しました。'
    redirect_to community
  end

  def destroy
    community = Community.find(params[:community_id])
    current_user.unjoin_community(community)
    flash[:success] = 'コミュニティを退出しました。'
    redirect_to community
  end
end
