class CommunitiesController < ApplicationController
  def index
  end
  
  def show
    if logged_in?
      @micropost = current_user.microposts.build  # form_with 用
      @microposts = current_user.microposts.order(id: :desc).page(params[:page])
      @community = Community.find(params[:id])
    end
  end

  def new
    @community = Community.new
  end

  def create
     @community = Community.new(community_params)

    if @community.save
      flash[:success] = 'コミュニティを登録しました。'
      redirect_to @community
    else
      flash.now[:danger] = 'コミュニティの登録に失敗しました。'
      render :new
    end
  end
  
  def community_params
    params.require(:community).permit(:name)
  end
end
