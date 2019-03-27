class TwitterInformationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_twitter_info, only: [:edit, :update, :destroy]
  before_action :only_current_user, only: [:edit, :update, :destroy]

  def create
    client = TwitterInformation.setClient()
    @user = User.find(params[:user_id])
    account = {
      'user': client.user(@user.twitter),
      'timeline': client.user_timeline(@user.twitter, count: 200)
    } if @user.twitter.present?

    @twitter_info = @user.build_twitter_information(set_params(account)) if account.present?

    if @twitter_info && @twitter_info.save
      @twitter_info.twitter_categories.build(label: '未設定', data: 100).save
      set_category_gon_data()
      respond_to do |format|
        flash[:success] = "Twitterアカウント情報を取得しました。"
        format.js { render :create }
      end
    else
      respond_to do |format|
        msg = '情報を取得できませんでした。ユーザー編集画面より、登録したTwitterアカウントIDをご確認ください。'
        flash[:danger] = @twitter_info ? @twitter_info.errors.full_messages : msg
        format.js {render 'layouts/error'}
      end
    end
  end

  def edit
  end

  def update
    @user = @twitter_info.user
    data_count = 0
    params[:twitter_information][:twitter_categories_attributes].each do |key, value|
      data_count += value[:data].to_i
    end

    if data_count != 100
      respond_to do |format|
        flash[:danger] = '合計を100%にしてください。'
        format.js {render 'layouts/error'}
      end
    elsif @twitter_info.update(set_twitter_categories_params)
      set_category_gon_data()
      respond_to do |format|
        flash[:success] = "内容を更新しました。"
        format.js { render :update }
      end
    else
      respond_to do |format|
        flash[:danger] = '更新できませんでした。'
        format.js {render 'layouts/error'}
      end
    end
  end

  private

  def set_twitter_info
    @twitter_info = TwitterInformation.find(params[:id])
  end

  def set_params(account)
      likedCount = 0
      retweetedCount = 0
      account[:timeline].each do |tweet|
        likedCount += tweet.favorite_count
        retweetedCount += tweet.retweet_count
      end
      params = {
        followers_count: account[:user].followers_count,
        followeds_count: account[:user].friends_count,
        favorites_count: account[:user].favorites_count,
        tweets_count: account[:user].statuses_count,
        account_created_at: account[:user].created_at,
        liked_count: likedCount,
        retweeted_count: retweetedCount,
      }
      params
  end

  def set_twitter_categories_params
    params.require(:twitter_information).permit(
      twitter_categories_attributes: [:id, :label, :data, :_destroy])
  end

  def set_category_gon_data
    gon.categoryLabel, gon.categoryData = @twitter_info.pluckColumns()
  end

  def only_current_user
    redirect_to advertisements_path, alert: "お探しのページへのアクセス権限がありません。" unless @twitter_info.user_id == current_user.id
  end
end
