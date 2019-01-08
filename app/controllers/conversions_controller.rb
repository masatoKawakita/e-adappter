class ConversionsController < ApplicationController
  before_action :authenticate_user!
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  
  def create
    if Conversion.where(conversation_id: params[:conversation_id], advertiser_id: params[:advertiser_id], diveloper_id: params[:diveloper_id]).present?
      conversions = Conversion.between(params[:diveloper_id], params[:advertiser_id])
      @conversion = conversions.find_by(conversation_id: params[:conversation_id])
    else
      @conversion = Conversion.create!(set_params)
    end

    respond_to do |format|
      if @conversion.save
        flash[:success] = "依頼申請を行いました。お相手が金額の設定を行うまでお待ちください。"
        format.js {render :create}
      else
        flash[:danger] = "エラーが発生しました。再度実行してください。"
        format.js {render 'layouts/error'}
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if params[:definitive_confirm].present?
        @conversation.advertisement.conversion.update(update_params)
        flash[:success] = "正式に依頼しました。"
        format.js {render :create}
      elsif params[:fee] == "clear"
        params[:fee] = nil
        if @conversation.advertisement.conversion.update(update_params)
          flash[:success] = "入力内容をキャンセルしました。" if params[:temporary_confirm] == "false"
          format.js {render :create}
        end
      elsif params[:fee].to_i == 0
        flash[:danger] = "金額を入力してください。（半角数字、1円以上）"
        format.js {render 'layouts/error'}
      elsif @conversation.advertisement.conversion.update(update_params)
        flash[:success] = "送信しました。お相手が確認するまでお待ちください。" if params[:temporary_confirm] == "true"
        format.js {render :create}
      else
        flash[:danger] = "エラーが発生しました。再度実行してください。"
        format.js {render 'layouts/error'}
      end
    end
  end

  def destroy
    @conversion = Conversion.find(params[:id]).destroy

    respond_to do |format|
      if @conversion.destroy
        flash[:success] = "依頼申請を解除しました。"
        format.js {render :create}
      else
        flash[:danger] = "エラーが発生しました。再度実行してください。"
        format.js {render 'layouts/error'}
      end
    end
  end

  private

  def set_params
    params.permit(:conversation_id, :advertisement_id, :advertiser_id, :diveloper_id)
  end

  def update_params
    params.permit(:temporary_confirm, :definitive_confirm, :fee)
  end
end
