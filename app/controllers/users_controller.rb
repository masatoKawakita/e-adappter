class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user, only: [:edit, :update, :destroy]
  include AdvertisementsHelper

  def index
    @users = User.search(params[:keyword])
    @users = @users.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @advertisements = Advertisement.where(user_id: @user.id)

    if @user.twitter_information.present?
      gon.categoryLabel, gon.categoryData = @user.twitter_information.pluckColumns()
    end
  end

  def edit
    @user = User.find(params[:id])
    @btn_label = "更新"
    redirect_to advertisements_path, alert: "お探しのページは表示できません。" unless @user == current_user
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
        format.js { render 'layouts/error' }
      end
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    sign_out(@user)
    redirect_to advertisements_path, notice: "アカウントを削除しました。"
  end

  private

  def set_params
    params.permit(:name, :content, :email, :twitter, :facebook, :icon,
                  :icon_cache, :want_to_advertise, :want_to_be_advertised)
  end

  def only_current_user
    @user = User.find(params[:id])
    redirect_to advertisements_path, alert: "お探しのページは表示できません。" unless @user == current_user  end
end
