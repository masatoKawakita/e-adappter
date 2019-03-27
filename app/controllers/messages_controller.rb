class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation
  before_action :set_messages
  include AdvertisementsHelper

  def index
    @conCase = @conversation.setCase(current_user)
  end

  def create
    @message = @conversation.messages.build(set_params)

    if @message.save
      respond_to do |format|
        flash[:success] = "メッセージを送信しました。"
        format.js {render :index}
      end
    else
      respond_to do |format|
        flash[:danger] = "メッセージを入力してください。"
        format.js {render 'layouts/error'}
      end
    end
  end

  private

  def set_params
    params.require(:message).permit(:body, :user_id)
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def set_messages
    @messages = @conversation.messages
    @messages.where.not(user_id: current_user.id).update_all(read: true) if @messages.last
    @messages = @messages.order(created_at: :desc)
    @message = @conversation.messages.build
    @sender = User.find(@conversation.sender_id)
  end
end
