class TabsController < ApplicationController
  def index
    @user = User.find(params[:user])
    @users = User.all
    @advertisements = Advertisement.where(user_id: @user.id)
    @favorites = Favorite.where(user_id: @user.id)
    type = params[:type]

    if type == "ad"
      render 'ad_tab.js.erb'
    elsif type == "liked"
      render 'liked_tab.js.erb'
    elsif type == "following"
      render 'following_tab.js.erb'
    elsif type == "followed"
      render 'followed_tab.js.erb'
    end
  end
end
