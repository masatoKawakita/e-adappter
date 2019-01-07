class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    @favorite = current_user.favorites.create(advertisement_id: params[:advertisement_id].to_i)
    @advertisement = Advertisement.find(params[:advertisement_id])
    if @favorite.save
      render 'index.js.erb'
    else
      redirect_to advertisement_path(params[:advertisement_id]), notice: "ストック失敗"
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(advertisement_id: params[:id].to_i).destroy
    @advertisement = Advertisement.find(params[:id])
    if @favorite.destroy
      render 'index.js.erb'
    else
      redirect_to advertisement_path(params[:id]), notice: "ストック失敗"
    end
  end
end
