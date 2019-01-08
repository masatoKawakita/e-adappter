class AdvertisementsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_ad, only: [:show, :edit, :update, :destroy]
  include AdvertisementsHelper

  def index
    @advertisements = Advertisement.search(params[:keyword])
    @advertisements = @advertisements.category_search(params[:app_category]) if params[:app_category].present?
    @advertisements = @advertisements.target_sex_search(params[:target_sex]) if params[:target_sex].present?
    @advertisements = @advertisements.target_age_search(params[:target_age]) if params[:target_age].present?
    @advertisements = @advertisements.request_follower_search(params[:request_follower]) if params[:request_follower].present?

    if params[:active].present?
      @advertisements = @advertisements.active_search(params[:active]) unless params[:active] == "all"
    end

    @advertisements = @advertisements.order(created_at: :desc)
  end

  def new
    @advertisement = Advertisement.new
    @btn_label = "投稿する"
  end

  def create
    @advertisement = Advertisement.new(set_params)
    @advertisement.user_id = current_user.id

    if @advertisement.save
      respond_to do |format|
        flash[:notice] = "アプリを投稿しました。"
        format.js { render ajax_redirect_to(advertisement_path(@advertisement.id)) }
      end
    else
      respond_to do |format|
        flash[:danger] = @advertisement.errors.full_messages
        format.js {render 'layouts/error'}
      end
    end
  end

  def show
    @favorite = current_user.favorites.find_by(advertisement_id: @advertisement.id)
    @comments = @advertisement.comments.order(created_at: :desc)
    @comment = @advertisement.comments.build
  end

  def edit
    advertisement = Advertisement.find(params[:id])
    @btn_label = "更新"
    redirect_to advertisements_path, alert: "お探しのページは表示できません。" unless advertisement.user_id == current_user.id
  end

  def update
    if @advertisement.update(set_params)
      respond_to do |format|
        flash[:notice] = "投稿を更新しました。"
        format.js { render ajax_redirect_to(advertisement_path(@advertisement.id)) }
      end
    else
      respond_to do |format|
        flash[:danger] = @advertisement.errors.full_messages
        format.js {render 'layouts/error'}
      end
    end
  end

  def destroy
    @advertisement.destroy
    redirect_to advertisements_path, notice: "投稿を削除しました。"
  end

  def pay
    # 実装保留

    # Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    # Stripe::Product.create(
    #   :name => 'ad_test',
    #   :type => 'good',
    #   :description => 'Comfortable cotton t-shirt',
    #   :attributes => ['size', 'gender']
    # )
    # Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    # Payjp::Event.create(amount: 1000, currency: 'jpy')
    # redirect_to root_path, notice: "プロダクト作成完了"
    # Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    # Payjp::Charge.create(currency: 'jpy', amount: 1000, card: params['payjp-token'])
    # redirect_to root_path, notice: "支払いが完了しました"
  end

  def sort
    @advertisements = Advertisement.where(id: params[:advertisements])

    if params[:type] == "sort_popular"
      ads_id = @advertisements.pluck(:id)
      favorites = Favorite.where(advertisement_id: ads_id).group(:advertisement_id).order('count(advertisement_id) desc').pluck(:advertisement_id)
      remains = ads_id - favorites
      favorites_array = favorites.push(remains)
      @advertisements = @advertisements.find(favorites_array)
    elsif params[:type] == "sort_new"
      @advertisements = @advertisements.order(created_at: :desc)
    end

    respond_to do |format|
      format.js {render :sort}
    end
  end

  private

  def set_params
    params.permit(:image, :image_cache, :blob, :title, :content,
      :app_url, :hash_01, :hash_02, :hash_03, :hash_04, :active,
      :about_function, :about_target, :about_condition, :about_fee,
      :request_follower, :target_sex, :target_age, :app_category)
  end

  def set_ad
    @advertisement = Advertisement.find(params[:id])
  end
end
