class UsersController < ApplicationController
  before_action :authenticate_user!
  include AdvertisementsHelper

  def index
    @users = User.search(params[:keyword])

    # if params[:keyword].present?
    #   render 'index.js.erb'
    # end
  end

  def show
    if params[:id].to_i == current_user.id
      @user = current_user
    else
      @user = User.find(params[:id])
    end
    @advertisements = Advertisement.where(user_id: @user.id)
  end

  def edit
    @user = current_user
    @btn_label = "更新"
  end

  def update
    if current_user.update(set_params)
      respond_to do |format|
        flash[:notice] = "ユーザー情報を更新しました。"
        format.js { render ajax_redirect_to(user_path(current_user.id)) }
      end
    else
      respond_to do |format|
        flash[:danger] = current_user.errors.full_messages
        format.js {render 'layouts/error'}
      end
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    sign_out(@user)
    redirect_to root_path, notice:"アカウント削除完了"
  end

  private

  def set_params
    params.permit(:name, :content, :email, :twitter, :facebook, :icon,
      :icon_cache, :want_to_advertise, :want_to_be_advertised)
  end
end
